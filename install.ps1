#2022 Jlangisch https://www.jlangisch.de https://www.jmg-it.de
#        
#        This program is free software: you can redistribute it and/or modify
#        it under the terms of the GNU General Public License as published by
#        the Free Software Foundation, either version 3 of the License, or
#        (at your option) any later version.  [the rest removed for clarity]



############################## DESCRIBTION ##############################
#This basically creates a user profile from the creds specified in get_creds.ps1 (execution pipeline normally) and runs the official ms teams installer with that user, from that user, in that user


######################################################################             Elevate to admin                                                 ######################################################################
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
    }
}
######################################################################             import creds and install                                         ######################################################################

$credspath = "C:\Program Files (x86)\teamsothertenant\creds.xml"
Write-Host "_________ ......Installing teamsothertennat ......_________" -f Magenta
$creds =import-clixml -path $credspath
Write-Host "_________ ....creds imported ......_________" -f Yellow
Write-Host $creds.UserName
Write-Host $creds.Password

######################################################################             define daemonuser and daemonpasswd                               ######################################################################
$daemonuser = $creds.UserName
$daemonpasswd = $creds.Password
$daemoncreds = New-Object System.Management.Automation.PSCredential $daemonuser, $daemonpasswd
Write-Host "_________ .....daemoncreds; creating admin......_________" -f Yellow

######################################################################             register daemonuser as new local user with specified creds       ######################################################################

New-LocalUser $daemonuser -Password $daemonpasswd -FullName "Teamsothertenant User" -Description "daemon f 2nd teams untl MS fixes their shit"
Write-Host "_________ ..... user [$daemonuser] created, trying to add to administrators ......_________" -f Yellow

######################################################################             add daemonuser to admins                                         ######################################################################
######################################################################             is that even nececary anymore? should test                       ######################################################################
######################################################################             this is shit but i dont know how to do it better                 ######################################################################
Add-LocalGroupMember -Group Administrators -Member $daemonuser -ErrorAction SilentlyContinue
Add-LocalGroupMember -Group Administratoren -Member $daemonuser -ErrorAction SilentlyContinue


######################################################################             run  the official ms teams installer as daemonuser              ######################################################################

Start-Process $installer_location -Credential $daemoncreds

#installer_location is defined in run.ps1