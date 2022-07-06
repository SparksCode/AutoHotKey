#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


File := A_ScriptDir
MsgBox, % MovedFile := MoveUpDirTree(File)

MoveUpDirTree(File) {
    FileMove, %File%, %File%\..
    SplitPath, File, FileName, FileDir
	MsgBox, %FileDir%
    Return, FileDir "\" File
}