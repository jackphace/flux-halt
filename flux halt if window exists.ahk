#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Match any window *containing* the text in a line of sensitive.txt
SetTitleMatchMode 2

;Assumes flux is on when started
fluxOff := false

;Check whether flux should be active every 4 seconds
SetTimer, PollWindowsForFlux, 4000
return

#t::
Goto, PollWindowsForFlux
return

PollWindowsForFlux:
;Check if there are sensitive windows
sensitive := SensitiveWindows()

;If there are no sensitive windows, flux should be on. If there are sensitive windows, flux should be off.
if(sensitive != fluxOff)
{	
	;Toggle flux with hotkey
	Send, {Alt down}{End down}{End up}{Alt up}
	
	;Update state of flux
	fluxOff := !fluxOff
}
return

SensitiveWindows()
{
	loop, read, sensitive.txt
	{
		sensitiveTitle := A_LoopReadLine
		
		IfWinExist, %sensitiveTitle%	
		{
			;MsgBox, %sensitiveTitle%			
			return true
		}
	}
	return false
}



