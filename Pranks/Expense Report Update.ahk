#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
#NoTrayIcon

Random, a, 1, 500
Random, b, 1, 500

gui, add, text, ,The system has experienced a fatal error and must be closed. 
gui, add, button, x137.5 gClose w40, Close
Gui, -SysMenu
gui, show, X%a% Y%B% w315 h60, System Error
return

Close:
run "Expense Report Update.ahk"
return