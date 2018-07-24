
#include *i Resources\config.ahk
DetectHiddenWindows, On
SetTitleMatchMode, 2

; ================================================================
; Start up
; ================================================================

If !FileExist("Resources\config.ahk"){
	MsgBox, No configuration found. `nOpening Start Up Configuration.
	Run, Configuration.ahk
	Exit app
}

; ================================================================
; Variables
; ================================================================

programList := []
otrList := []
backgroundList := []
programLines := 

; ================================================================
; Build Lists
; ================================================================

Loop, Read, Resources\Program.txt
{	
   	programLines = %A_Index%
	programList.Insert(A_LoopReadLine)

}

Loop, Read, Resources\OTR.txt
{
   	otrLines = %A_Index%
	otrList.Insert(A_LoopReadLine)
}

Loop, Read, Resources\Background.txt
{
   	backgroundLines = %A_Index%
	backgroundList.Insert(A_LoopReadLine)
}

; ================================================================
; Run Programs
; ================================================================

runCategory(programLines, programList, ProgramSettings)
runCategory(otrLines, otrList, OTRSettings)
runCategory(backgroundLines, backgroundList, BackgroundSettings)

runCategory(Lines, listArray, settingsArray)
{
	If (Lines > 0)
	{
		for key, val in settingsArray
		{
			If (val = 1)
			{
				rawText := listArray[key]
				Text := RegExReplace(rawText, "\W", "")
				runProgram(Text)
			}
		}
	}
}

runProgram(programName)
{
	IfWinNotExist, %programName%
	{
		itemLocation := %programName%Location
		runProgram := locationCheck(itemLocation, programName)
		if(runProgram = 1)
		{
			Run, %itemLocation%
		}
	}
}

; ================================================================
; Error Check
; ================================================================

locationCheck(location, program)
{
	StringLen, var1, location

	locationError = Location of %program% could not be found. Please reconfigure in settings.
	If(var1 = 0){
		MsgBox, %locationError%
		Run, Configuration.ahk
		return 0
	}
	Else If !FileExist(location){
		MsgBox, %locationError%
		Run, Configuration.ahk
		return 0
	}

	return 1
}

; ================================================================
; End
; ================================================================

return