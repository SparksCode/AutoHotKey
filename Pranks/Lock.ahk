#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

; use f11 to block input for 10 secs
a::
  blockinput,on
  sleep 10000
  blockinput,off
return

; holding appskey and pressing x abort
delete & x::
  blockinput,off
return