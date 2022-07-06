#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


configFile := A_ScriptDir . "\FIS Daily.zip"
unzipDir := MoveUpDirTree(configFile)
unzip := unzipDir . "\FIS2Daily\"
Unz(configFile,unzip)

MoveUpDirTree(File) {
    SplitPath, File, FileName, FileDir
	SplitPath, FileDir, FileName, FileDir
    Return, FileDir
}

Unz(configFile, unzip)
{
    fso := ComObjCreate("Scripting.FileSystemObject")
    If Not fso.FolderExists(unzip)  
       fso.CreateFolder(unzip)
    psh  := ComObjCreate("Shell.Application")
    zippedItems := psh.Namespace( configFile ).items().count
    psh.Namespace( unzip ).CopyHere( psh.Namespace( configFile ).items, 4|16 )
    Loop {
        sleep 50
        unzippedItems := psh.Namespace( unzip ).items().count
        ToolTip Unzipping in progress..
        IfEqual,zippedItems,%unzippedItems%
            break
    }
    ToolTip
}

return