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

KeyEvent(code, state){
	ToolTip % "Keyboard Key - Code: " code ", State: " state
}
  
MouseButtonEvent(code, state){
	ToolTip % "Mouse Button - Code: " code ", State: " state
    IF (code:=0)
         AHI.SendKeyEvent(keyboardId,  GetKeySC("a"), 1)
}

MouseMove(x, y){
    
    IF x<0
    {
        MouseGetPos, MX, MY ;separated from another ToolTip
        ToolTip % "Mouse Move (" x " , " y ")", MX+30, MY+30
        Send, {Left}        
    }
    ELSE
    {
        AHI.SendKeyEvent(keyboardId, "HO", 1)
    }  
    IF (y<0) {
        AHI.SendKeyEvent(keyboardId, GetKeySC("Down"), 1)
    }
    Else
    {
         AHI.SendKeyEvent(keyboardId, GetKeySC("Right"), 1)
    }
       
    AHI.SendKeyEvent(keyboardId, 0, 0)
}

Esc::ExitApp
Return