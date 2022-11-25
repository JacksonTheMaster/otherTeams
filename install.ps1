
Write-Host "_________ ......Installing teamsothertennat ......_________" -f Magenta
Write-Host "_________ In the next screen, you will specify credentials. ......_________" -f White
Write-Host "_________ These will be used to create local administrator _________" -f White
Write-Host "_________ use something like teamsothertenant // 76()//8vb%m9c098p>4c8 _________" -f White
Write-Host "_________ feel free to use keyboard spam if you dont want access to the account _________" -f White
Write-Host "_________ DO NOT USE DOMAIN ACCOUNTS OR EXISTING ONES_________" -f Red
$Shell = New-Object -ComObject "WScript.Shell"
$Button = $Shell.Popup("
In the next screen, you will specify credentials
These will be used to create local administrator
use something like teamsothertenant // 76()//8vb%m9c098p>4c8
feel free to use keyboard spam if you dont want access to the account
DO NOT USE DOMAIN ACCOUNTS OR EXISTING ACCOUNTS

CLICK OK TO PROCEED
", 0, "IMPORTANT INFORMATION", 0)
$credspath = $Env:Programfiles+"\teamsothertenant\creds.xml"

Write-Host $credspath

Get-Credential | Export-Clixml -Path $credspath

$creds =import-clixml -path $credspath
Write-Host "_________ ....creds imprte ......_________" -f Yellow
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