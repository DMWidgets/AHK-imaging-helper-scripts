found = 0

sleep 180000
Gosub ForceUpdates
sleep 120000
Gosub runSCCM
run KIS_1.7.3.exe
SetKeyDelay 1000
Gosub 10mincycle

10mincycle:
Loop
{
send {LWin 2}
Gosub checkforskype
run restart_checker.exe
;Gosub restart_pending
sleep 300000
send {LWin 2}
sleep 300000
}
return


ForceUpdates:
	{
	;FormatTime, TimeString,, Time
	;Gui, Add, Text,, Last Run: %TimeString%
	;Gui, Show, AutoSize, Force SCCM and GPupdate
	run cmd
	sleep 1000
	send gpupdate /force{enter}
	run control smscfgrc
	WinWait Configuration Manager Properties
	WinActivate Configuration Manager Properties
	SetKeyDelay 300

	;selects action tab
	send {ctrl down}{tab 2}{ctrl up}
	sleep 100
	
	;runs Application Deployment Evaluation Cycle
	send {down}!r{enter}
	sleep 100

	;runs Machine Policy Retrieval & Evaluation cycle
	send {down 4}!r{enter}
	sleep 100

	;runs Software Inventory Cycle 
	send {down}!r{enter}
	sleep 100
	
	;runs Software Updates Deployment Evaluation Cycle
	send {down 3}!r{enter}
	sleep 100

	;runs Software Updates Scan Cycle
	send {down}!r{enter}
	sleep 100

	;runs User Policy Retrieval & Evaluation Cycle
	send {down}!r{enter}

	;closes windows after waiting
	sleep 120000
	WinClose Configuration Manager Properties
	WinClose C:\windows\system32\cmd.exe

}
return

runSCCM:
SetKeyDelay 1000
run C:\Windows\CCM\SCClient.exe
WinWait, Software Center
WinActivate, Software Center
sleep 60000
return

restart_pending:
;in order for imagesearch to work correctly, it seems that the window being searched must be active. at least, the tray does.
send {LWin down}b{LWin up}{enter}{up}
sleep 1000
Loop, 3 {
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *20 %A_ScriptDir%\restartpending.png
}
If %ErrorLevel% = 0
	{
		send {LWin}{right 2}r
	}
	else
	{
	send {down}{esc}
	}
return

checkforskype:
if (%found% = 0)
{
IfExist, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office 2013\Skype for Business 2015.lnk
	{
		run "C:\Windows\Media\Raga\Windows Battery Critical.wav"
		Gui, New: new,, skype check
		Gui, Add, text,, `!`!Skype for Business Installed`!`!
		Gui, Show, Autosize Center
		found = 1		
	}
return
}
return

^q::
ExitApp