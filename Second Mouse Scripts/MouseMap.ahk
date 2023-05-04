#SingleInstance force
#Persistent
#include Lib\AutoHotInterception.ahk

AHI := new AutoHotInterception()

keyboardId := AHI.GetKeyboardId(0x045E, 0x0745)
AHI.SubscribeKeyboard(keyboardId, false, Func("KeyEvent"))

mouseIdM := AHI.GetMouseId(0x045E, 0x0745) 
AHI.SubscribeMouseMove(mouseIdM, true, Func("MouseMove"))

mouseId := AHI.GetMouseId(0x045E, 0x0745) 
AHI.SubscribeMouseButtons(mouseId, true, Func("MouseButtonEvent"))
return
tiempo:=500
KeyEvent(code, state){
	ToolTip % "Keyboard Key - Code: " code ", State: " state
}
  
MouseButtonEvent(code, state){
	ToolTip % "Mouse Button - Code: " code ", State: " state
    IF (code=5)
        IF(state0-1)
            Send, {Z}
            sleep, tiempo 
        ElSE
            Send, {Shift}{Z}
            sleep, tiempo 

}

MouseMove(x, y){
    MouseGetPos, MX, MY ;separated from another ToolTip
    ToolTip % "Mouse Move (" x " , " y ")", MX+30, MY+30
    IF x<0
    {
        Send, {Left}
        sleep, tiempo   
    }
    ELSE
    {
        Send, {Right}
        sleep, tiempo   
    }  
    IF (y<0) {
        Send, {Down}
        sleep, tiempo
    }
    Else
    {
        Send, {Up}
        sleep, tiempo
    }
       
    AHI.SendKeyEvent(keyboardId, 0, 0)
}

^!p::Pause    ; Pause script with Ctrl+Alt+P
^!s::Suspend  ; Suspend script with Ctrl+Alt+S
^!r::Reload   ; Reload script with Ctrl+Alt+R

^Esc::ExitApp	; Exit the script with Ctrl+Esc