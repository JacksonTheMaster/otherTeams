# Self-elevate the script if required reddit shit
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
    }
}


Write-Host "_________ In the next screen, you will specify credentials. ......_________" -f White
Write-Host "_________ These will be used to create local administrator _________" -f White
Write-Host "_________ use something like teamsothertenant // 76()//8vb%m9c098p>4c8 _________" -f White
Write-Host "_________ feel free to use keyboard spam if you dont want access to the account _________" -f White
Write-Host "_________ DO NOT USE DOMAIN ACCOUNTS OR EXISTING ONES_________" -f Red
#$Shell = New-Object -ComObject "WScript.Shell"
#$Button = $Shell.Popup("
#In the next screen, you will specify credentials
#These will be used to create local administrator
#use something like teamsothertenant // 76()//8vb%m9c098p>4c8
#feel free to use keyboard spam if you dont want access to the account
#DO NOT USE DOMAIN ACCOUNTS OR EXISTING ACCOUNTS
#CLICK OK TO PROCEED
#", 0, "IMPORTANT INFORMATION", 0)



$credential 
$credspath = $Env:Programfiles+"\teamsothertenant\creds.xml"
Write-Host $credspath
$daemonuser_secstring = Read-Host "Enter a Username"
$daemonpasswd_secstring = Read-Host "Enter a Password" -AsSecureString

Write-Host "2"
$daemoncreds_securestring = New-Object System.Management.Automation.PSCredential $daemonuser_secstring, $daemonpasswd_secstring
Write-Host "3"
cd 'C:\Program Files (x86)\teamsothertenant'


$daemoncreds_securestring | Export-Clixml -Path ./creds.xml