$daemonuser = "Teamsothertennant"
$daemonpasswd = ConvertTo-SecureString "Teams" -AsPlainText -Force
$daemoncreds = New-Object System.Management.Automation.PSCredential $daemonuser, $daemonpasswd

$currentuser=(Get-WmiObject -Class win32_computersystem).UserName.split('\')[1]

$currentpasswd = ConvertTo-SecureString "not-referenced" -AsPlainText -Force

$is_installed_path = $Env:Programfiles+"\teamsothertenant\is_installed.blob"

$installerScriptPath = Split-Path $MyInvocation.InvocationName

cd $Env:Programfiles\teamsothertenant\

if (-not(Test-Path -Path $is_installed_path -PathType Leaf)) {
     try {
         
         & $PSScriptRoot\install.ps1
         $null = New-Item -ItemType File -Path $is_installed_path -Force -ErrorAction Stop
         Write-Host "The file [is_installed_path] has been created."
     }
     catch {
         throw $_.Exception.Message
     }
 }
# If the file already exists, show the message and do nothing.
 else {
     Write-Host "Cannot create [$file] because a file with that name already exists."
 }
#New-LocalUser $daemonuser -Password $passwd -FullName "Teamsothertenant User" -Description "system account for adding another teams instance to your PC until MS fixes their shit"


#cd C:\Users\$daemonuser\AppData\Local\Microsoft\Teams\current\
#Start-Process "C:\Users\Teams\AppData\Local\Microsoft\Teams\current\Teams.exe" -Credential $daemoncreds



#move shortcut to startmenu C:\Users\$currentuser\AppData\Roaming\Microsoft\Windows\Start Menu\Programs