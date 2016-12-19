;What Kyle hath wrought, let no bug put asunder

;Gui settings
Gui, Main: new,, KIS 1.7.4 
Gui, Add, text,, Alt+Q to quit
Gui, Add, text,,  --------------
Gui, Add, button, gsccm, &1. Soft&ware Center
Gui, Add, button, gMALL, &2. Software Mall
Gui, Add, button, gBZPDF_install, &3. Install Bluezone and PDF Factory
Gui, Add, button, gBPDO_install, &4. Install Bluezone`, PDF Factory`, DB2
Gui, Add, Button, gForceUpdates +Default, &5. Update Group Policy and run all client actions
Gui, Add, Button, gPolicyReset, &6. Reset and Request Machine Policy
Gui, Add, Button, gIncrementCache, &7. Increase Cache
Gui, Add, text,, Run Joindom, input User ID below
Gui, Add, edit, r1 vUSERID
Gui, Add, Button, gJoinDom, &8. Join
Gui, Add, Button, gInstall850driver, &9. Install 850G3 Video Driver
Gui, Add, button, gpatch_report, &P. Run Patch Report
Gui, Add, button, gtoggle_restarter, &R. Toggle Restart Script
Gui, Main:Show, Autosize x100 y100 Center
return

;Policy reset
PolicyReset:
IfWinExist, Administrator: C:\Windows\System32\cmd.exe
{
	WinActivate, Administrator: C:\Windows\System32\cmd.exe
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

;run patchreport.vbs
patch_report:
run PatchReport.vbs
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
run JoinDomW7.exe
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

BPDO_install:
gosub, runSCCM
gosub, runSoftCat
gosub, PDF_Factory_install
gosub, DB2_install
;gosub, oracle86_install
;gosub, oracle64_install
gosub, Bluezone_install
WinClose Application installation result - Internet Explorer
return

DB2_install:
sleep 3000
SetKeyDelay 50
WinActivate, Application Catalog - Internet Explorer
send db2{space}connect{space}v10{enter}
sleep 5000
WinActivate, Application Catalog - Internet Explorer
send {Ctrl down}{Alt down}a{Ctrl up}{Alt up}
sleep 3000
send {enter}
WinWait, Application installation result - Internet Explorer
WinActivate, Application installation result - Internet Explorer
sleep 3000
send {tab 2}
return

oracle64_install:
sleep 3000
SetKeyDelay 50
WinActivate, Application Catalog - Internet Explorer
send oracle{space}12c{space}client{space}{shift down}9{shift up}x64{shift down}0{shift up}{enter}
sleep 5000
WinActivate, Application Catalog - Internet Explorer
send {Ctrl down}{Alt down}a{Ctrl up}{Alt up}
sleep 3000
send {enter}
WinWait, Application installation result - Internet Explorer
WinActivate, Application installation result - Internet Explorer
sleep 3000
send {tab 2}
return

oracle86_install:
sleep 3000
SetKeyDelay 50
WinActivate, Application Catalog - Internet Explorer
send oracle{space}12c{space}client{space}{shift down}9{shift up}x86{shift down}0{shift up}{enter}
sleep 5000
WinActivate, Application Catalog - Internet Explorer
send {Ctrl down}{Alt down}a{Ctrl up}{Alt up}
sleep 3000
send {enter}
WinWait, Application installation result - Internet Explorer
WinActivate, Application installation result - Internet Explorer
sleep 3000
send {tab 2}
return

Bluezone_install:
sleep 3000
SetKeyDelay 50
WinActivate, Application Catalog - Internet Explorer
send bluez{enter}
sleep 5000
WinActivate, Application Catalog - Internet Explorer
send {Ctrl down}{Alt down}a{Ctrl up}{Alt up}
sleep 3000
send {enter}
WinWait, Application installation result - Internet Explorer
WinActivate, Application installation result - Internet Explorer
sleep 3000
send {tab 2}
return

Install850driver:
run Intel Video Drive 20.19.15.4457-May-2016-sp76114.exe
WinWait, Intel Video Driver and Control Panel - InstallShield Wizard
WinActivate, Intel Video Driver and Control Panel - InstallShield Wizard
sleep 3000
SetKeyDelay 50
send n{up}{enter 2}
WinWait, Installation Framework
WinActivate, Installation Framework
sleep 3000
send nyn
return

PDF_Factory_install:
sleep 3000
SetKeyDelay 50
WinActivate, Application Catalog - Internet Explorer
send pdf{space}factory{space}v{enter}
sleep 5000
WinActivate, Application Catalog - Internet Explorer
send {Ctrl down}{Alt down}a{Ctrl up}{Alt up}
sleep 3000
send {enter}
WinWait, Application installation result - Internet Explorer
WinActivate, Application installation result - Internet Explorer
sleep 3000
SetKeyDelay 1000
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

MALL:
run InstallMenu.exe
return

sccm:
run C:\Windows\CCM\SCClient.exe
return

toggle_restarter:
IfExist, C:\Users\*USERID*\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Restarter_1.7.exe
	{
		send {ctrl down}q{ctrl up}
		FileDelete, C:\Users\*USERID*\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Restarter_1.7.exe
	}
	else
	{
		FileCopy, M:\Restarter_1.7.exe, C:\Users\*USERID*\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
		run C:\Users\*USERID*\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Restarter_1.7.exe
	}
return

Quit:
Gui, PRwin:destroy
return


!q::
ExitApp

GuiClose:
ExitApp