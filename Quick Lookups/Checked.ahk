; Create the ListView with two columns, Name and Size:
Gui, Add, ListView, r20 w700 gMyListView checked, Name|Size (KB)

; Gather a list of file names from a folder and put them into the ListView:
Loop, %A_MyDocuments%\*.*
	LV_Add("", A_LoopFileName, A_LoopFileSizeKB)

LV_ModifyCol()  ; Auto-size each column to fit its contents.
LV_ModifyCol(2, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.

; Display the window and return. The script will be notified whenever the user double clicks a row.
Gui, Show
return

MyListView:
if A_GuiEvent = DoubleClick
{
	LV_GetText(RowText, A_EventInfo)  ; Get the row's first-column text.
	MsgBox You double-clicked row number %A_EventInfo%. Text: "%RowText%"
}
return

3::
test := LV_GetNext(0, "Checked") 
msgbox %test%

CountAll := LV_GetCount()
CountChecked := 0
RowNumber := 0
Loop
{
	RowNumber := LV_GetNext(RowNumber , "Checked")
	If Not RowNumber        ; no more checked rows
		break
	CountChecked++
}
Msgbox % CountChecked . " / " . CountAll . " are checked."

return


GuiClose:  ; Indicate that the script should exit automatically when the window is closed.
ExitApp