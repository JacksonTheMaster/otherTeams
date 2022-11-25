#$daemonuser = "Teamsothertennant"
#$daemonuser = creds.UserName
#$daemonpasswd = ConvertTo-SecureString "924bc34b2a890635fe1151e41f68adc2" -AsPlainText -Force 
#$daemonpasswd = creds.Password
#maybe generate uniqe passwd per user, but unsure how to store it properly -> maybe i did?
#$daemoncreds = New-Object System.Management.Automation.PSCredential $daemonuser, $daemonpasswd
$currentuser=(Get-WmiObject -Class win32_computersystem).UserName.split('\')[1]
#$credspath = $Env:Programfiles+"\teamsothertenant\creds.xml"
#$creds =import-clixml -path $credspath
#$currentpasswd = ConvertTo-SecureString "not-referenced" -AsPlainText -Force
$installer_location = $Env:Programfiles+"\teamsothertenant\TeamsSetup.exe"



$blobfile = $Env:Programfiles+"\teamsothertenant\is_installed.blob"

$installerScriptPath = Split-Path $MyInvocation.InvocationName

cd $Env:Programfiles\teamsothertenant\

if (-not(Test-Path -Path $blobfile -PathType Leaf)) {
    try {
        Write-Host "_________ ..... Isnt installed, trying to start install ......_________" -f Yellow
        & $PSScriptRoot\install.ps1
        $null = New-Item -ItemType File -Path $blobfile -Force -ErrorAction Stop
        Write-Host "_________ ..... Daemon sucsessfully installed ......_________" -f Yellow
        Write-Host "The checkfile at [$blobfile] has been created"
    }
    catch {
        throw $_.Exception.Message
    }
}
# If the file a lready exists, show the message and do nothing.
else {
    Write-host "_________ This message is intended _________" -f Cyan
    Write-Host "will not install and prepare a deamon user again for teams other tenant as the checkfile [$blobfile] already exists. If you are re-installing or debugging, ensure to check if you deleted all the entries in program files and your user start menu in appdata " -f Yellow
    & $PSScriptRoot\start.ps1
}



#cd C:\Users\$daemonuser\AppData\Local\Microsoft\Teams\current\
#Start-Process "C:\Users\Teams\AppData\Local\Microsoft\Teams\current\Teams.exe" -Credential $daemoncreds



#move shortcut to startmenu C:\Users\$currentuser\AppData\Roaming\Microsoft\Windows\Start Menu\Programs