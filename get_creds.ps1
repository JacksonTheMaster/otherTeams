#2022 Jlangisch https://www.jlangisch.de https://www.jmg-it.de
#        
#        This program is free software: you can redistribute it and/or modify
#        it under the terms of the GNU General Public License as published by
#        the Free Software Foundation, either version 3 of the License, or
#        (at your option) any later version.  [the rest removed for clarity]
# Self-elevate the script if required reddit shit





############################## DESCRIBTION ##############################
#This basically creates a PScred/Windows cred  and stores it in an XML




######################################################################             Elevate to admin                                                       ######################################################################
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
    }
}





######################################################################             Info for getting creds                                                  ######################################################################
Write-Host "_________ In the next screen, you will specify credentials. ......________________" -f White
Write-Host "_________ These will be used to create local administrator _______________________" -f Red
Write-Host "_________ use something like teamsothertenant // 76/8vb%m9c#098p>4c8 _____________" -f White
Write-Host "__________________________________________________________________________________" -f White
Write-Host "_________ DO NOT USE DOMAIN ACCOUNTS OR EXISTING ONES_____________________________" -f Red
Write-Host "_________ IF YOU HAVE PASSWORD POLICIES IN PLACE YOU NEED TO RESPECT THEM_________" -f Red
Write-Host "_________ IF YOU HAVE PASSWORD POLICIES IN PLACE YOU NEED TO RESPECT THEM_________" -f Red
Write-Host "_________ If ou see a short error and nothing happens, set a better passwd________" -f Red
Write-Host "_________ feel free to use keyboard spam if you dont need access to the account___" -f Red
Write-Host "_________ IF YOU HAVE PASSWORD POLICIES IN PLACE YOU NEED TO RESPECT THEM_________" -f Red






######################################################################             create a local user profile                                              ######################################################################
$credential 
$credspath = $Env:Programfiles+"\teamsothertenant\creds.xml"
Write-Host $credspath
$daemonuser_secstring = Read-Host "Enter a Username"
$daemonpasswd_secstring = Read-Host "Enter a Password" -AsSecureString


######################################################################        bake the creds file                                                           ######################################################################
$daemoncreds_securestring = New-Object System.Management.Automation.PSCredential $daemonuser_secstring, $daemonpasswd_secstring
Set-Location 'C:\Program Files (x86)\teamsothertenant'

######################################################################             Export creds.xml to 'C:\Program Files (x86)\teamsothertenant'            ######################################################################
$daemoncreds_securestring | Export-Clixml -Path ./creds.xml