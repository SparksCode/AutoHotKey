      LR:=" %ç+*/()= 01  ö!ABCDEabcde:,;zZ"
;      New := RegExReplace(LR, "[^A-Z]")        ; allow only A-Z
;      New := RegExReplace(LR, "\W", " ")      ; allow A-Z/a-z/0-9 and space
      New := RegExReplace(LR, "\W", "")       ; same      without space
msgbox,"%new%"
return