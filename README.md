# AHK-imaging-helper-scripts

This repo contains AHK scripts I've written to help streamline the tempermental process of imaging new laptops in my corporate environment. Much of the process is "hurry up and wait" so short bursts of user input happen every 20 minutes or so which necessitates someone babysitting the machines. These scripts are written so to the end that they do the lion's share of the babysitting.

#KIS_1.4.5 (run as Admin)

produces a GUI that includes commonly used processes that saves time seeking and running the desired action

1. Installs Bluezone and PDF Factory via SCCM
2. Forces group policy update via cmd and runs through client update actions via the configuration manager
3. Resets and requests machine policy
4. quick paths to cache window to increase/delete cache
5. runs joindom executable to add user to computer with provided userID (this won't work unless you change exe's dir; coded to my needs by default)
6. partially starts the video driver installation process for the new laptop model

#Restarter_1.2

Advised to add to windows startup folder. Does much of the "babysitting" of the laptop. waits until all services have loaded after restart via long delay, runs the second command from KIS, installs available programs within SCCM, waits 20~ minutes and keeps the screen awake until the script reboots the machine.


TODO - find out why SCCM is so awful. :)

#mouseposandcolor

hotkey: ctrl+shift+z

captures and displays mouse's current position and pixel color of position.
