#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
#NoTrayIcon

;Random, a, 1, 1500
;Random, b, 1, 1000

randomArray := ["C:\Windows\System32\write.exe","C:\Windows\System32\cmd.exe","C:\Windows\System32\mspaint.exe", "C:\Windows\System32\calc.exe", "C:\Windows\System32\notepad.exe"]

a := 750
b := 500

gui, add, text, ,The system has experienced a fatal error and must be closed. 
gui, add, button, x104.5 y30 gLog w50, Error Log
gui, add, button, x160.5 y30 gClose w50, Close
Gui, -SysMenu
Gui, +ToolWindow
gui, show, X%a% Y%B% w315 h60, System Error

WinActivate, System Error
return

Log:
Loop, 50{
	Random, arrayLoc, 1, 5
	rando := randomArray[arrayLoc]
	Run, %rando%
	Sleep, 250
}
return

Close:
run "Trip Itinerary.ahk"
return