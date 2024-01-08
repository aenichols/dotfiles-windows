#Requires AutoHotkey v2.0

; Ctrl+Win+Esc
#^Esc::
{
    Title := WinGetTitle("A")
    TRANL := WinGetTransparent(Title)

    If (TRANL = "off" or TRANL = "") {
        WinSetTransparent 220, Title ; 180
    } Else {
        WinSetTransparent "off", Title
    }
    return
}

; Keep Alive
SetTimer KeepAwake,480000 ; run every 8 minutes
return

KeepAwake()
{
    MouseMove 0,0,0,"R" ; mouse pointer stays in place but sends a mouse event
}

^0::
{
    Send "Keep-Alive is running"
    Return
}
