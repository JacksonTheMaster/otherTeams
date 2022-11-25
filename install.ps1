$credspath = "C:\Program Files (x86)\teamsothertenant\creds.xml"
Write-Host "_________ ......Installing teamsothertennat ......_________" -f Magenta
$creds =import-clixml -path $credspath
Write-Host "_________ ....creds imported ......_________" -f Yellow
Write-Host $creds.UserName
Write-Host $creds.Password
$daemonuser = $creds.UserName
$daemonpasswd = $creds.Password
$daemoncreds = New-Object System.Management.Automation.PSCredential $daemonuser, $daemonpasswd
Write-Host "_________ .....daemoncreds......_________" -f Yellow





New-LocalUser $daemonuser -Password $daemonpasswd -FullName "Teamsothertenant User" -Description "daemon f 2nd teams untl MS fixes their shit"
Write-Host "_________ ..... user [$daemonuser] created, trying to add to administrators ......_________" -f Yellow
Add-LocalGroupMember -Group Administrators -Member $daemonuser -ErrorAction SilentlyContinue
Add-LocalGroupMember -Group Administratoren -Member $daemonuser -ErrorAction SilentlyContinue

Start-Process $installer_location -Credential $daemoncreds