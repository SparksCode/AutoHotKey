#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


CurrentDate := A_Now
FormatTime, DayofWeek, ,dddd


if (DayofWeek = "Monday") {
}
else if (DayofWeek = "Tuesday") {
CurrentDate += -1, days
}
else if (DayofWeek = "Wednesday") {
CurrentDate += -2, days
}
else if (DayofWeek = "Thursday") {
CurrentDate += -3, days
}
else if (DayofWeek = "Friday") {
CurrentDate += -4, days
}
else if (DayofWeek = "Saturday") {
CurrentDate += -5, days
MsgBox The Cafeteria is Closed today.
}
else if (DayofWeek = "Sunday") {
CurrentDate += -6, days
MsgBox The Cafeteria is closed today.
}

FormatTime, UseDate, %CurrentDate%, MMddyy

Run iexplore.exe https://www.fisandme.com/camp/nrtham/Arkansas/LR/Cafe`%20Sodexho/SI`%20Cafe`%20%UseDate%.pdf
                