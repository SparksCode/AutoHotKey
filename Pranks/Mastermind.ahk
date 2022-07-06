; AHK Mastermind
; (c) 2008 derRaphael / Zlib License Style Released

  #NoTrayIcon
  SetTitleMatchMode, 2

  BLOCK  := Chr(0xDB) Chr(0xDB), CNTbl  := "RYOGBN"
  CTable := "ff0000|ffff00|ff8000|00ff00|0000ff|804000"

  Menu, Game, Add, New Game`tCTRL+N, ReStart
  Menu, Game, Add, Exit Game`tALT+F4, GuiClose
  Menu, GameMenu, Add, &Game, :Game

  GoSub, initGame
  GoSub, initRound
return

initGame:
  Round  := 12
  Guess  := "----"
  Loop, 12
  {
    L := A_Index
    Loop, 4
      Gui, Add, CheckBox, % "hwndR" L "_" A_Index " vlR" L "_" A_index 
                          . " Disabled x"  ((A_Index>1) ? "p+15" : "10")
                          . " h10 w10"
    Gui, Font, s36 cd0d0d0, Terminal
    Loop, 4
      Gui, Add, Text, % "+Border hwndG" L "_" a_index " vlG" L "_" A_index 
                      . " y" ((A_Index>1)? "p":"p-5") " xp+21", % BLOCK
  }
  Gui, Font,s13, Lucida Console
  Loop, 4
    Gui, Add, Button, % "gBC w35 h35 +Center x"
                      . ((A_Index>1)? "p+38":10) ((A_Index>1)? "yp":"")
                      , &%A_Index%

  Gui, Font
  Gui, Add, Button, h20 x10 +Center w150 gCheck, &Check my guess
  Gui, Menu, GameMenu
  Gui, Show,, MasterMind
return

initRound:
  youWontKnow := ""
  Random,,WinActive("A")
  Loop, 4
  {
     Random, rndm, 1, StrLen(CNTbl)
     youWontKnow .= s(CNTbl,rndm,1)
  }
;  SetTimer, TT, 100
return

TT:
   ToolTip, % youWontKnow
return

Check:
   If InStr(Guess,"-")
      MsgBox,64,Hint,You are missing one or more colors!
   else 
   {
     CCP := CCC := 0, YWK := youWontKnow
     Loop, Parse, Guess
       If InStr(YWK,A_LoopField) 
       {
           StringReplace, YWK, YWK, A_LoopField
           CCC += 1
       }
     Loop, 4
       If (s(youWontKnow,A_Index,1)=s(Guess,A_Index,1))
           CCP += 1
     Loop, %CCC%
     {
       id := "R" Round "_" A_Index,  id := %id%
       Control,Enable,,,ahk_id %id%
     }
     Loop, %CCP%
     {
       id := "R" Round "_" A_Index,  id := %id%
       Control,Check,,,ahk_id %id%
;       GuiControl,, %id%, 1

     }
     Guess := "----", Round -= 1
   }

   if !(Round) AND (CCP!=4)
   {
      MsgBox,64,Oh nooooo!,You've lost The Game! Try harder next time!
      Gosub, ReStart
   }
   if (CCP=4)
   {
      MsgBox,64,Congratulations!,You've won the Game!
      Gosub, ReStart
   }
return

#IfWinActive, MasterMind
^n::
ReStart:
  Gui, 1:Destroy
  GoSub, InitGame
  GoSub, InitRound
return

BC:
  StringRight, ButtonNumber, A_GuiControl, 1
  Gui, Font, s36 ce0e0e0, Terminal
  GuiControl, Font, % "lG" Round "_" ButtonNumber

  SetFormat, Integer, hex
  Gui, 1:+Disabled
  Gui, 2:+ToolWindow +Owner +AlwaysOnTop

  Loop, Parse, CTable, |
  {
    a := A_Index, x := (a>1) ? "p+15" : 1
    t := s(CNTbl,a,1), alf := A_LoopField
    Hotkey, %t%, CC, ON
    Gui, 2:Font
    Gui, 2:Font, s36 c%alf%, Terminal
    Gui, 2:Add, Text, vB%t% gCC +Border x%x% y1, % BLOCK
    x := (a>1) ? "p+6" : 7
    N := ("0x" s(alf,1,2)), N := N//2, c := (s(N,3)="0") ? "00" : s(N,3)
    N := ("0x" s(alf,3,2)), N := N//2, c .= (s(N,3)="0") ? "00" : s(N,3)
    N := ("0x" s(alf,5,2)), N := N//2, c .= (s(N,3)="0") ? "00" : s(N,3)
    Gui, 2:Font, s10 bold c%c%, Lucida Console
    Gui, 2:Add, Text, gCC x%x% y3 +BackgroundTrans vT%t%, &%t%
  } 

  Gui, 2:Show, h21 w127, Pick the Color!
return

CC:
  if A_ThisHotkey
     Pos := InStr(CNTbl,A_ThisHotkey)
  if A_GuiControl
     Pos := InStr(CNTbl,s(A_GuiControl,2,1))
  Counter := 0

  Loop, Parse, CTable, |
    If Counter = %Pos%
      break
    else
      Color := A_LoopField, Counter+=1

  Gosub, 2GuiEscape

  Gui, 1:Default
  Gui, Font, s36 c%Color%, Terminal
  GuiControl, Font, % "lG" Round "_" ButtonNumber

  Guess := s(Guess,1,ButtonNumber-1) s(CNTbl,Pos,1) s(Guess,ButtonNumber+1)
return

2GuiClose:
2GuiEscape:
  Gui, Font, s36 cd0d0d0, Terminal
  GuiControl, Font, % "lG" Round "_" ButtonNumber

  Loop, Parse, CNTbl
     Hotkey, %A_LoopField%, CC, OFF

  Gui, 1:-Disabled
  Gui, 2:Destroy
return

GuiClose:
  ExitApp

s(a,b,c=1024)
{
 return, % SubStr(a,b,c)
}