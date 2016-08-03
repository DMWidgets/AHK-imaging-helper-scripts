;What Kyle hath wrought, let no computer put asunder

;Gui settings
Gui, Main: new,, Update`, Damn It! 
Gui, Add, text,, Install Bluezone and PDF Factory
Gui, Add, button, gBZPDF_install, M&ake it so
Gui, Add, Text,, Updates Group Policy and Software Center
Gui, Add, Button, gForceUpdates +Default, &Force Updates
Gui, Add, Text,, Reset and Request Machine Policy
Gui, Add, Button, gPolicyReset, &MP mulligan
Gui, Add, Text,, Insufficient &Space?
Gui, Add, Button, gIncrementCache, &Increase Cache
Gui, Add, text,, Run Joindom, input User ID below
Gui, Add, edit, r1 vUSERID
Gui, Add, Button, gJoinDom, Put 'em on the &list
Gui, Add, Button, gInstall850driver, Install 850G3 &Video Driver
Gui, Main:Show, Autosize x100 y100 Center
return

;Policy reset
PolicyReset:
IfWinExist, Administrator: C:\windows\system32\cmd.exe
{
	WinActivate, Administrator: C:\windows\system32\cmd.exe
	send WMIC /NameSpace:\\root\ccm path SMS_Client Call ResetPolicy 1{enter}
	Sleep 10000
	send WMIC /NameSpace:\\root\ccm path SMS_Client Call RequestMachinePolicy{enter}
	return	
}
else
{
	Gui, PRwin: new,, Notice 
	Gui, Add, Text,, Please open cmd as Admin and retry
	Gui, Add, Button, gQuit +Default, &OK
	Gui, Show, x100 y100 Center
	return
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

;increase the cache size
IncrementCache:
	{
	run control smscfgrc
	WinWait Configuration Manager Properties
	WinActivate Configuration Manager Properties
	SetKeyDelay 300

	;selects action tab
	send {ctrl down}{tab 4}{ctrl up}{tab}{enter}
	sleep 100
	return
}

;Runs Joindom
JoinDom:
run Z:\JoinDomW7.exe
WinWait MDT Join Domain Process
WinActivate MDT Join Domain Process
sleep 500
Gui, submit, nohide
send %USERID%{tab}{enter}
sleep 500
send {enter}
return

BZPDF_install:
gosub, runSCCM
gosub, runSoftCat
gosub, Bluezone_install
gosub, PDF_Factory_install
WinClose Application installation result - Internet Explorer
return

Bluezone_install:
SetKeyDelay 300
send bluez{enter}
sleep 5000
send {Ctrl down}{Alt down}a{Ctrl up}{Alt up}
sleep 1000
send {enter}
WinWait, Application installation result - Internet Explorer
WinActivate, Application installation result - Internet Explorer
sleep 2000
send {tab 4}
return

PDF_Factory_install:
SetKeyDelay 300
send pdf{space}factory{space}v{enter}
sleep 5000
send {Ctrl down}{Alt down}a{Ctrl up}{Alt up}
sleep 1000
send {enter}
WinWait, Application installation result - Internet Explorer
WinActivate, Application installation result - Internet Explorer
send {tab 4}
return

DEPRECATED_PDF_Factory_install:
SetKeyDelay 30
send pdf factory{enter}
sleep 3000
send {tab 11}{down}{tab 10}{enter}
sleep 1000 
send {enter}
Gosub, installed
return

installed:
Loop {
	sleep 1000
	PixelGetColor, InstWin1, 355, 293, alt	;use default position
	;Gui, Colortest: new,, Notice 
	;Gui, Add, Text,, %InstWin1%
	;Gui, Show, NoActivate x100 y100 Center, Colortest
	if (InstWin1 = 0x00A424 or InstWin1 = 0x2CB249 or InstWin1 = 0xe36c92) 
		{
		sleep 1000
		send {tab 4}
		return
		}		
	else 
		{
		continue
		}
	}
return

runSCCM:
run C:\Windows\CCM\SCClient.exe
WinWait, Software Center
WinActivate, Software Center
sleep 12000
return

runSoftCat:
WinActivate, Software Center
SetKeyDelay 300
send {tab 5}{enter} ;opens software catalogue
WinWait, Application Catalog - Internet Explorer
sleep 3000
return

Install850driver:
run "Intel Video Drive 20.19.15.4457-May-2016-sp76114.exe", R:\GRDUtils\Drivers\Laptop-Desktop Drivers\850 G3 Drivers
WinWait, Intel Video Driver and Control Panel - IntallShield Wizard
WinActivate, Intel Video Driver and Control Panel - IntallShield Wizard
SetKeyDelay 300
send n{up}{enter 2}
return

Quit:
Gui, PRwin:destroy
return

^q:
Exit

!q::
ExitApp

GuiClose:
Exit