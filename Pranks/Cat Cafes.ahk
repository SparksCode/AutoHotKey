#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

c::
     BlockInput, MouseMove
     loop, 500{
	SendInput, Like OMG what is happening? `n
	Sleep, 250
     }
     BlockInput, MouseMoveOff
return
