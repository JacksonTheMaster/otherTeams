
Write-Host "_________ ......Installing teamsothertennat ......_________" -f Magenta
New-LocalUser $daemonuser -Password $daemonpasswd -FullName "Teamsothertenant User" -Description "daemon f 2nd teams untl MS fixes their shit"
Write-Host "_________ .....trying to add to administrators ......_________" -f Yellow
Add-LocalGroupMember -Group Administrators -Member $daemonuser -ErrorAction SilentlyContinue
Add-LocalGroupMember -Group Administratoren -Member $daemonuser -ErrorAction SilentlyContinue


Start-Process $installer_location -Credential $daemoncreds