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
StateM:=0

AHI := new AutoHotInterception()

keyboardId := AHI.GetKeyboardId(0x045E, 0x0745)
AHI.SubscribeKeyboard(keyboardId, false, Func("KeyEvent"), False)

;mouseIdM := AHI.GetMouseId(0x045E, 0x0745) ;Microsoft Wireless Mouse 5000
mouseIdM := AHI.GetMouseId(0x13BA, 0x0018) ;Original Microsoft IntelliMouse PS2
AHI.SubscribeMouseMove(mouseIdM, true, Func("MouseMoves"), False)

mouseId := AHI.GetMouseId(0x045E, 0x0745) 
AHI.SubscribeMouseButtons(mouseId, true, Func("MouseButtonEvent"), False)
return



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
         Send, {f}
         Sleep, 2000
    }
    if(code=4){
         Send, {Space}
    }
    if(code=3){
         Send, {m}
    }
}

MouseMoves(x, y){
    global StateM
   ;ToolTip % "M---- Move (" X1 " , " Y1 ")", MX-300, MY-300
   MouseGetPos, MX, MY ;separated from another ToolTip
    ToolTip % StateM " Mouse Move (" x " , " y ")", MX-300, MY-300
    if (StateM>=4){
        if (x<0)    {
            Send, {Left} 
        } else if(x>0) {
            Send, {Right} 
        } 
        if (y>0) {
            Send, {Down}
        } else if(y<0) {
            Send, {Up}
        }
        StateM:=0
    }
    StateM:=StateM+1
}

^!p::Pause    ; Pause script with Ctrl+Alt+P
^!s::Suspend  ; Suspend script with Ctrl+Alt+S
^!r::Reload   ; Reload script with Ctrl+Alt+R

^Esc::ExitApp	; Exit the script with Ctrl+Esc