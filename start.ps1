#2022 Jlangisch https://www.jlangisch.de https://www.jmg-it.de
#        
#        This program is free software: you can redistribute it and/or modify
#        it under the terms of the GNU General Public License as published by
#        the Free Software Foundation, either version 3 of the License, or
#        (at your option) any later version.  [the rest removed for clarity]






############################## DESCRIBTION ##############################
#this imports the creds specified in get_creds.ps1 and starts the already installed otherTeams instance









######################################################################                  Variables START                                      ######################################################################
######################################################################                  import the creds to PS                               ######################################################################
$credspath = "C:\Program Files (x86)\teamsothertenant\creds.xml"
$creds =import-clixml -path $credspath
######################################################################           didnt work without that, lets keep it for now               ######################################################################
Write-Host "_________ ....creds imported ......_________" -f Yellow
Write-Host $creds.UserName
Write-Host $creds.Password
######################################################################                   get creds from variable and store in variables      ######################################################################
$daemonuser = $creds.UserName
$daemonpasswd = $creds.Password 


######################################################################                   bake the creds together again                                     ######################################################################
$daemoncreds = New-Object System.Management.Automation.PSCredential $daemonuser, $daemonpasswd
######################################################################                  build a filepath to run the installer in                           ######################################################################
$teams_root_filepath = "C:\Users\"+$daemonuser+"\AppData\Local\Microsoft\Teams\current\Teams.exe"
Write-Host "_________ ......Starting teams from [$teams_root_filepath]......_________" -f Magenta
######################################################################         install from filepath and hope that windows decides it exists               ######################################################################
Start-Process $teams_root_filepath -Credential $daemoncreds