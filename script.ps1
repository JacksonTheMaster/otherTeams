$daemonuser = "Teamsothertennant"
$daemonpasswd = ConvertTo-SecureString "924bc34b2a890635fe1151e41f68adc2" -AsPlainText -Force 
#maybe generate uniqe passwd per user, but unsure how to store it properly
$daemoncreds = New-Object System.Management.Automation.PSCredential $daemonuser, $daemonpasswd
Write-Host $daemoncreds
$currentuser=(Get-WmiObject -Class win32_computersystem).UserName.split('\')[1]

$currentpasswd = ConvertTo-SecureString "not-referenced" -AsPlainText -Force
$teams_root_filepath = "C:\Users\"+$daemonuser+"\AppData\Local\Microsoft\Teams\current\Teams.exe"
$installer_location = $Env:Programfiles+"\teamsothertenant\TeamsSetup.exe"

Write-Host $installer_location
$is_installed_path = $Env:Programfiles+"\teamsothertenant\is_installed.blob"

$installerScriptPath = Split-Path $MyInvocation.InvocationName

cd $Env:Programfiles\teamsothertenant\

if (-not(Test-Path -Path $is_installed_path -PathType Leaf)) {
    try {
        Write-Host "_________ ..... Isnt installed, trying to start install ......_________" -f Yellow
        & $PSScriptRoot\install.ps1
        $null = New-Item -ItemType File -Path $is_installed_path -Force -ErrorAction Stop
        Write-Host "_________ ..... Daemon sucsessfully installed ......_________" -f Yellow
        Write-Host "The checkfile at [$is_installed_path] has been created"
    }
    catch {
        throw $_.Exception.Message
    }
}
# If the file a lready exists, show the message and do nothing.
else {
    Write-host "_________ This message is intended _________" -f Cyan
    Write-Host "will not install and prepare the deamon user [$daemonuser] again for teams other tenant as the checkfile [$is_installed_path] already exists. If you are re-installing or debugging, ensure to check if you deleted all the entries in program files and your user start menu in appdata " -f Yellow
    & $PSScriptRoot\start.ps1
}



#cd C:\Users\$daemonuser\AppData\Local\Microsoft\Teams\current\
#Start-Process "C:\Users\Teams\AppData\Local\Microsoft\Teams\current\Teams.exe" -Credential $daemoncreds



#move shortcut to startmenu C:\Users\$currentuser\AppData\Roaming\Microsoft\Windows\Start Menu\Programs