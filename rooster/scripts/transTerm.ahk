;Ctrl+Win+Esc

#^Esc::
  WinGet, TransLevel, Transparent, A
  If (TransLevel = OFF) {
    WinSet, Transparent, 245, A ; 180
  } Else {
    WinSet, Transparent, OFF, A
  }
return

; Google Search highlighted text
^+c::
{
 Send, ^c
 Sleep 50
 Run, http://duckduckgo.com/?q=%Clipboard%
 Return
}

;Always On Top
^SPACE::  Winset, Alwaysontop, , A

;Keep Alive
SetTimer,KeepAwake,480000         ;run every 8 minutes
return
 
KeepAwake:
{
     MouseMove,0,0,0,R ; mouse pointer stays in place but sends a mouse event
}
return

^0::
   Send, Keep-Alive is running
Return