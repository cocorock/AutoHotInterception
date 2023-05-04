; The directives below should not be commented out as they control the script's behavior.
#SingleInstance force
#Persistent
#include <AutoHotInterception>
#NoEnv  
SetWorkingDir %A_ScriptDir%

; Initialize state variable for mouse movement
StateM:=0

; Create an instance of AutoHotInterception
AHI := new AutoHotInterception()

; Get the ID for the keyboard
keyboardId := AHI.GetKeyboardId(0x045E, 0x0745)
; Subscribe to keyboard events
AHI.SubscribeKeyboard(keyboardId, false, Func("KeyEvent"), False)

; Get the ID for the mouse
mouseIdM := AHI.GetMouseId(0x13BA, 0x0018) 
; Subscribe to mouse move events
AHI.SubscribeMouseMove(mouseIdM, true, Func("MouseMoves"), False)

; Get the ID for the mouse
mouseId := AHI.GetMouseId(0x045E, 0x0745) 
; Subscribe to mouse button events
AHI.SubscribeMouseButtons(mouseId, true, Func("MouseButtonEvent"), False)
return

; Function to handle keyboard events
KeyEvent(code, state){
	ToolTip % "Keyboard Key - Code: " code ", State: " state
}

; Function to handle mouse button events
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

; Function to handle mouse move events
MouseMoves(x, y){
    global StateM
    MouseGetPos, MX, MY 
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

; Hotkeys to control the script
^!p::Pause    ; Pause script with Ctrl+Alt+P
^!s::Suspend  ; Suspend script with Ctrl+Alt+S
^!r::Reload   ; Reload script with Ctrl+Alt+R
^Esc::ExitApp	; Exit the script with Ctrl+Esc
