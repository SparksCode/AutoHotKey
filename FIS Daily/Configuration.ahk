#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force ; Ensures only one Configuration active 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include *i Resources\pending.ahk
#include *i Resources\config.ahk

; ================================================================
; Variable Initializations
; ================================================================

titleText = FIS Daily Configurations
global User

ConfigProgram := []
ConfigScript := []
ConfigBackground := []

global defaultScripts := ["Idle", "Lunch Menu", "Misspellings", "Time Clock"]
global configFileList := []
global listCategories := ["ProgramList", "OTRList", "BackgroundList"]

global ProgramSettings
global OTRSettings
global BackgroundSettings

programList = Resources\Program.txt
scriptList = Resources\OTR.txt
backgroundList = Resources\Background.txt

; ================================================================
; Previous Saved Configuration
; ================================================================

If FileExist("Resources\config.ahk"){
	User = %User%
	titleText = %User% - FIS Daily Configurations
}
If !FileExist("Resources\config.ahk")
{
	outlookLocation = C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE
	skypeLocation = C:\Program Files (x86)\Microsoft Office\root\Office16\lync.exe
}
If !FileExist("Resources\pending.ahk")
{
	buildDefault()
	Run, Configuration.ahk
}
; ================================================================
; Window Settings
; ================================================================

Menu, tray, Icon, Resources\FIS.jpg, 1, 1
Gui, Show, x159 y116 h300 w506, %titleText%

; ================================================================
; Picture
; ================================================================

Gui, Add, Picture, x376 y16 w110 h110, Resources\FIS.jpg

; ================================================================
; User
; ================================================================

Gui, Add, Edit, vUserID x376 y137 w110 h20, % User

; ================================================================
; ListViews
; ================================================================

Gui, Add, ListView, Checked r9 w110 gProgramItemClick vProgramList x16 y16, Programs
Gui, Add, ListView, Checked r9 w110 gOTRItemClick vOTRList x136 y16, Scripts
Gui, Add, ListView, Checked r9 w110 gBackgroundItemClick vBackgroundList x256 y16, Background Scripts

; ================================================================
; Buttons
; ================================================================

Gui, Add, Button, gSave x376 y167 w50 h30, Save
Gui, Add, Button, gCancel x436 y167 w50 h30, Cancel

Gui, Add, Button, gAddProgram x16 y207 w50 h30, Add
Gui, Add, Button, gAddOTR x136 y207 w50 h30, Add
Gui, Add, Button, gAddBackground x256 y207 w50 h30, Add

; ================================================================
; Populate ListViews
; ================================================================

getLists()

Return

; ================================================================
; ListView Clicks
; ================================================================

ProgramItemClick:
	Gui, ListView, ProgramList
	if A_GuiEvent = DoubleClick
	{
		itemCheck()
	}
return

OTRItemClick:
	Gui, ListView, OTRList
	if A_GuiEvent = DoubleClick
	{
		itemCheck()
	}
return

BackgroundItemClick:
	Gui, ListView, BackgroundList
	if A_GuiEvent = DoubleClick
	{
		itemCheck()
	}
return

; ================================================================
; Button Clicks
; ================================================================

AddProgram:	
	addList("Program", "Program")
return

AddOTR:	
	addList("OTR", "Script")
return

AddBackground:	
	addList("Background", "Background Script")
return

Save:
	Gui, Submit
	
	checkUser()
	copyStartUp()
	getListViewChecked()
	configAppend(buildConfig())
	
	ExitApp

return

Cancel:
	ExitApp
return

; ================================================================
; Functions
; ================================================================

itemCheck()
{
		LV_GetText(RowText, A_EventInfo)
		updateList(RowText)
}

checkUser()
{
	global UserID
	StringLen, userSize, UserID
	
	If !FileExist("Resources\config.ahk")
	{
		If(UserSize = 0)
		{
			MsgBox, User ID invald!
			Run, Configuration.ahk
			return
		}
		User = %UserID%
	}

	Else
	{	
		If(UserSize > 0)
		{
			User = %UserID%
		}
	}
}

getLists()
{
	global programList, scriptList, backgroundList
	If FileExist(programList)
	{
		Gui, ListView, ProgramList
		Loop, read, %programList%
		{
			listItem = %A_LoopReadLine%
			populateListViews(listItem)
		}
	}
	If FileExist(scriptList)
	{
		Gui, ListView, OTRList
		Loop, read, %scriptList%
		{
			listItem = %A_LoopReadLine%
			populateListViews(listItem)
		}
	}
	If FileExist(backgroundList)
	{
		Gui, ListView, BackgroundList
		Loop, read, %backgroundList%
		{
			listItem = %A_LoopReadLine%
			populateListViews(listItem)
		}
	}
}

populateListViews(listItem)
{
	LV_Add("Check", listItem)
}

getCheckedItems(RowNumber, listConfig)
{
	checkedCount = 0

	Loop % LV_GetCount()
	{
		SendMessage, 4140, RowNumber - 1, 0xF000, SysListView321

		LV_GetText(rawText, RowNumber)
		
		Text := RegExReplace(rawText, "\W", "")
		;StringReplace , Text, rawText, %A_Space%,,All

		nextCheck := LV_GetNext(RowNumber - 1, "Checked")
		;MsgBox, %RowNumber% : %nextCheck%
		
		If (RowNumber = nextCheck)
		{	
			IsChecked = 1
			If (RowNumber - 1 = 0)
			{
				listConfig = %listConfig%1
			}
			Else
			{
				listConfig = %listConfig%, 1
			}
			checkedCount += 1
		}
		Else
		{
			If (RowNumber - 1  = 0)
			{
				listConfig = %listConfig%0
			}
			Else
			{
				listConfig = %listConfig%, 0
			}
			checkedCount += 1
		}
		
		itemLocation := %Text%Location
		
		If (IsChecked = 1) && (itemLocation = "")
		{
			MsgBox, %rawText% location not found.
			itemLocation := selectFile()	
			itemLocation = %Text%Location := "%itemLocation%"
		}
		Else
		{
			itemLocation = %Text%Location := "%itemLocation%"
		}

		configFileList.Insert(itemLocation)
		RowNumber += 1
	}
	
	listConfig = %listConfig%]
	
	return listConfig
}

getListViewChecked()
{		
	for key, val in listCategories
	{
	RowNumber = 1

	Gui, 1:ListView, %val%
		
		If (key = 1)
		{
			listConfig = ProgramSettings := [
			ProgramSettings := getCheckedItems(RowNumber, listConfig)
		}
		If (key = 2)
		{
			listConfig = OTRSettings := [
			OTRSettings := getCheckedItems(RowNumber, listConfig)
		}
		If (key = 3)
		{
			listConfig = BackgroundSettings := [
			BackgroundSettings := getCheckedItems(RowNumber, listConfig)
		}
	}
}

updateList(fileName)
{
	pendingFile := selectFile()
	
	fileName := RegExReplace(fileName, "\W", "")
	
	FileAppend, 
	(
	`n%fileName%Location := "%pendingFile%"
	), Resources\pending.ahk
	
	updateConfig(fileName)
}

addList(fileType, typeTitle)
{
	InputBox, pendingName, Add %typeTitle% to Configuration
	pendingFile := selectFile()
	
	FileAppend, 
	(
	`n%pendingName%
	), Resources\%fileType%.txt
	
	pendingName := RegExReplace(pendingName, "\W", "")
	
	FileAppend, 
	(
	`n%pendingName%Location := "%pendingFile%"
	), Resources\pending.ahk

	Run, Configuration.ahk
}

selectFile()
{
	FileSelectFile, SelectedFile, 3, , Open a file
	if SelectedFile =
    		MsgBox, The user didn't select anything.
	else
    		return %SelectedFile%
	return 
}

buildConfig()
{
	global User
	User = User = %User%
	
	ConfigSettings = %User%`n%ProgramSettings%`n%OTRSettings%`n%BackgroundSettings%

	for key, val in configFileList
	{
		ConfigSettings = %ConfigSettings%`n%val%
	}
	return %ConfigSettings%
}

configAppend(ByRef ConfigSettings)
{
	FileAppend, 
	(
	%ConfigSettings%
	), temp.ahk
	
	FileMove, temp.ahk, Resources\config.ahk, 1
}

copyStartUp()
{
	StartUp = C:\Users\%User%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Start Up.lnk
	
	If !FileExist(StartUp)
	{
		FileCreateShortcut, C:\Users\%User%\Documents\Testing\FIS Daily\Start Up.ahk, %A_Startup%\Start Up.lnk, %A_ScriptDir%
	}
}

updateConfig(fileName)
{	
	fileread, config, Resources\config.ahk
	
	loop, parse, config, `n
	{
		if InStr(A_LoopField, fileName)
		{
		}
		else
		{
			FileAppend, 
			(
			%A_LoopField%`n
			), temp.ahk
		}
	}
	
	FileMove, temp.ahk, Resources\config.ahk, 1
	Run, Configuration.ahk 
}

buildDefault()
{	
	for key, val in defaultScripts
	{
		pendingName := RegExReplace(val, "\W", "")
	
		FileAppend, 
		(
		`n%pendingName%Location := "%A_WorkingDir%\Scripts\%val%.ahk"
		), Resources\pending.ahk
	}
}

; ================================================================
; Exit
; ================================================================

GuiClose:
	ExitApp
