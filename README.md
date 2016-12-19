# AHK-imaging-helper-scripts

This repo contains AHK scripts I've written to help streamline the tempermental process of imaging new laptops in my corporate environment. Much of the process is "hurry up and wait" so short bursts of user input happen every 20 minutes or so which necessitates someone babysitting the machines. These scripts are written to the end that they do the lion's share of the babysitting.

#KIS_1.7.4 (run as Admin)

produces a GUI that includes commonly used processes that saves time seeking and running the desired action

1. shortcuts to software mall and SCCM
2. installs some commonly selected programs via SCCM
3. Resets and requests machine policy
4. quick paths to cache window to increase/delete cache
5. runs joindom executable to add user to computer with provided userID 
6. partially starts the video driver installation process for the new laptop model
7. runs patch report to show how far along the patching process is
8. toggles the installation and running of the restart checking script

#Restarter_1.7

Advised to add to windows startup folder (can be accomplished by running action R in KIS). Does much of the "babysitting" of the laptop. waits until all services have loaded after restart via long delay, runs the fifth command from KIS, keeps screen awake until detects restart pending from SCCM, restarts machine.


TODO - find out why SCCM is so awful. :)
     - find out why ahk's image search function is picky about resolution across computers

#mouseposandcolor

hotkey: ctrl+shift+z

captures and displays mouse's current position and pixel color of position.
