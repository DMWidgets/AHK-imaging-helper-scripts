sleep 180000
Gosub ForceUpdates
sleep 120000
Gosub runSCCM
;Gosub install_all_available_software ;don't need to run this, most software will install by itself anyways
Gosub wait_and_restart

wait_and_restart:
SetKeyDelay 1000
sleep 300000 ;40 min keepalive
send {LWin 2}
sleep 300000
send {LWin 2}
sleep 300000
send {LWin 2}
sleep 300000
send {LWin 2}
sleep 300000
send {LWin 2}
sleep 300000
send {LWin 2}
sleep 300000
send {LWin 2}
sleep 300000
send {LWin 2}
send {LWin}{right 2}r{enter}
return

install_all_available_software:
SetKeyDelay 1000
MouseMove 22,191
click
sleep 1000
MouseMove 1099, 710
click
;send {tab 23}{enter}{enter}
return 

runSCCM:
SetKeyDelay 1000
run C:\Windows\CCM\SCClient.exe
WinWait, Software Center
WinActivate, Software Center
sleep 60000
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
