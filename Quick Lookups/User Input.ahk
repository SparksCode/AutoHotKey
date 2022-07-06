#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force



Gui, Show, x159 y116 h300 w506, Test
Gui, Add, Button, gAddProgram x380 y130 w50 h30, Save

return

AddProgram:
	InputBox, nameTest, Add Program to Configuration
	test := selectFile()
	MsgBox, %nameTest% Location at %test%
return

selectFile()
{
	FileSelectFile, SelectedFile, 3, , Open a file, Text Documents (*.txt; *.doc)
	if SelectedFile =
    		MsgBox, The user didn't select anything.
	else
    		return %SelectedFile%
	return 
}