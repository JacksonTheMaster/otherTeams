$credspath = "C:\Program Files (x86)\teamsothertenant\creds.xml"
$creds =import-clixml -path $credspath
Write-Host "_________ ....creds imported ......_________" -f Yellow
Write-Host $creds.UserName
Write-Host $creds.Password
$daemonuser = $creds.UserName
$daemonpasswd = $creds.Password
$daemoncreds = New-Object System.Management.Automation.PSCredential $daemonuser, $daemonpasswd
$teams_root_filepath = "C:\Users\"+$daemonuser+"\AppData\Local\Microsoft\Teams\current\Teams.exe"
Write-Host "_________ ......Starting teams from [$teams_root_filepath]......_________" -f Magenta
Start-Process $teams_root_filepath -Credential $daemoncreds