#Requires AutoHotkey v2.0
BaseInterval := 5000
SetTimer(PerformActions, GetJitteredInterval(BaseInterval))

WKeyHeld := false              ; Track if W is being held
LastRPress := A_TickCount      ; Track the last time R was pressed

GetJitteredInterval(Base) {
    ; Add a random jitter to the base interval
    return Base + GetJitter(1000, 1000)
}

GetJitter(Min, Max) {
    return Random(Min, Max)
}

StartScript() {
    global WKeyHeld
    Send("{w down}")           
    WKeyHeld := true
}

StopScript() {
    global WKeyHeld
    if (WKeyHeld) {
        Send("{w up}")         
        WKeyHeld := false
    }
    ExitApp()                  
}

PerformActions() {
    global LastRPress
    ; Press R every 15 seconds
    if (A_TickCount - LastRPress >= 15000) {
        Send("r")
        LastRPress := A_TickCount
    }
    if (WKeyHeld) {
        Send("{w up}")
        Sleep(100)             
        Send("{w down}")
    }
    ; Click at the current mouse position
    Click()
}

; Hotkeys to start/stop the script
^s::StartScript()   
^q::StopScript()    
