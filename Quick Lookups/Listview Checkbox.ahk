#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#SingleInstance Force

Gui, Add, ListView, Checked r4 w100 gMyListView vProgramList, Test|T
	LV_Add("Check", "uuuu", 2)
	LV_Add("Check", "vvvv", "Two")
	LV_Add("Check", "wwww", "Two")
	LV_Add("Check", "xxxx", "Two")
	LV_Add("Check", "yyyy", "Two")
	LV_Add("Check", "zzzz", "Two")
	LV_Add("Button", "a", 2)


; Create the ListView with two columns, Name and Size:
Gui, Add, ListView, r20 w700 gMyListView, Name|Size (KB)

; Gather a list of file names from a folder and put them into the ListView:
;Loop, %A_MyDocuments%\*.*
;    LV_Add("", A_LoopFileName, A_LoopFileSizeKB)

;LV_ModifyCol()  ; Auto-size each column to fit its contents.
;LV_ModifyCol(2, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.

; Display the window and return. The script will be notified whenever the user double clicks a row.


Gui, Show

MsgBox % LVGetCheckedItems("SysListView321", "Listview Checkbox.ahk")
return

MyListView:
if A_GuiEvent = DoubleClick
{
    LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
    ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
}
return

;Function
LVGetCheckedItems(cN,wN) {
    ControlGet, LVItems, List,, % cN, % wN
    Pos:=!Pos,Item:=Object()
    While Pos
        Pos:=RegExMatch(LVItems,"`am)(^.*?$)",_,Pos+StrLen(_)),mCnt:=A_Index-1,Item[mCnt]:=_1
    Loop % mCnt {
        SendMessage, 0x102c, A_Index-1, 0x2000, % cN, % wN
        ChkItems.=(ErrorLevel ? Item[A_Index-1] "`n" : "")
    }
    Return ChkItems
}

GuiClose:  ; Indicate that the script should exit automatically when the window is closed.
ExitApp