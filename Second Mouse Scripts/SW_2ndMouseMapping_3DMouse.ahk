;#SingleInstance force
;Persistent
;#include Lib\AutoHotInterception.ahk
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force
#Persistent
#include <AutoHotInterception>
X1:=0
Y1:=1

AHI := new AutoHotInterception()

keyboardId := AHI.GetKeyboardId(0x045E, 0x0745)
AHI.SubscribeKeyboard(keyboardId, false, Func("KeyEvent"))

mouseIdM := AHI.GetMouseId(0x045E, 0x0745) 
AHI.SubscribeMouseMove(mouseIdM, true, Func("MouseMoves"))

mouseId := AHI.GetMouseId(0x045E, 0x0745) 
AHI.SubscribeMouseButtons(mouseId, true, Func("MouseButtonEvent"))
return

SetTimer, T, 1000
Return


KeyEvent(code, state){
	ToolTip % "Keyboard Key - Code: " code ", State: " state
}
  
MouseButtonEvent(code, state){
	ToolTip % "Mouse Button - Code: " code ", State: " state
    if (code=5){
        if(state=1){
            Send, {Z}
        }else{
            Send, {z}
        }
    }
    if (code=2){
         Send, {Space}
    }
    if(code=4){
         Send, {f}
    }
}

MouseMoves(x, y){
    global X1, Y1
    X1:=x
    Y1:=y
    ;ToolTip % "M---- Move (" X1 " , " Y1 ")", MX-300, MY-300
}

T:
    MouseGetPos, MX, MY ;separated from another ToolTip
    ToolTip % "Mouse Move (" X1 " , " Y1 ")", MX-300, MY-300
    if (X1<0)    {
        Send, {Left} 
    } else if(X1>0) {
        Send, {Right} 
    } 
    if (Y1<0) {
        Send, {Down}
    } else if(Y1>0) {
        Send, {Up}
    }
Return

^!p::Pause    ; Pause script with Ctrl+Alt+P
^!s::Suspend  ; Suspend script with Ctrl+Alt+S
^!r::Reload   ; Reload script with Ctrl+Alt+R

^Esc::ExitApp	; Exit the script with Ctrl+Esc