#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; List the key-value pairs of an object:
colours := Object("red", 0xFF0000, "blue", 0x0000FF, "green", 0x00FF00)
; The above expression could be used directly in place of "colours" below:
for k, v in colours
    s .= k "=" v "`n"
MsgBox % s


config := ["one", "two", "three"] 
config.Insert("four")

programs := Object(config[1], "Location", config[2], "Location", config[3], "Location")
programs.Insert(config[4], "Location")
for k, v in programs
	loc .= k " := " """" "%" v "%" """" "`n"
MsgBox % loc 