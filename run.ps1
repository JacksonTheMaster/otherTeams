#2022 Jlangisch https://www.jlangisch.de https://www.jmg-it.de
#        
#        This program is free software: you can redistribute it and/or modify
#        it under the terms of the GNU General Public License as published by
#        the Free Software Foundation, either version 3 of the License, or
#        (at your option) any later version.  [the rest removed for clarity]








############################## DESCRIBTION ##############################
#this is the main functionality. It decides if the installer should run (get_creds, install (.ps1) ) and if not, it just starts otherTeams with the last known creds
#multiuser support is technically no problem at all. just change the creds file, or use gui at some point (gui in first alpha, idk how to code it lol)













######################################################################             Variables (1)                                                                                              ######################################################################
$installer_location = "C:\Program Files (x86)\teamsothertenant\TeamsSetup.exe"
Write-Host $installer_location
$blobfile = "C:\Program Files (x86)\teamsothertenant\is_installed.blob"



######################################################################             elevate to admin                                                                                            ######################################################################
# Self-elevate the script if required reddit shit

if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
    }
}




######################################################################             run the installers only if a blobfile (checkfile) is not created yet                                         ######################################################################
######################################################################             "if file NOT exists = get creds and install with those creds else do nothing but kill yourself"              ######################################################################
if (-not(Test-Path -Path $blobfile -PathType Leaf)) {
    try {
        Write-Host "_________ ..... Isnt installed, trying to create creds ......_________" -f Yellow
        #shouldnt be installed, lets see what happens if i run create creds by running get_creds.ps1...
        & $PSScriptRoot\get_creds.ps1
        
        Write-Host "_________ ..... Isnt installed, trying to setup user ......_________" -f Yellow
        #user shouldnt be created, lets see what happens if i create by running install.ps1...
        & $PSScriptRoot\install.ps1

        #if all that shit worked, mark the PC as "installed" by creating a BLOB. what else? --> could probably be done properly with regestry, but no.
        $null = New-Item -ItemType File -Path $blobfile -Force -ErrorAction Stop
        Write-Host "_________ ..... Daemon sucsessfully installed ......_________" -f Yellow
        Write-Host "The checkfile at [$blobfile] has been created"
        #read lines above
    }
    catch {
        throw $_.Exception.Message
    }
}
######################################################################  If the file a lready exists, show the message and do nothing but start Otherteams ###################################################################### 
else {
    Write-host "_________ This message is intended _________" -f Cyan
    Write-Host "will not install and prepare a deamon user again for teams other tenant as the checkfile [$blobfile] already exists. If you are re-installing or debugging, ensure to check if you deleted all the entries in program files and your user start menu in appdata. use the uninstaller in Windows menu -APPS- " -f Yellow
    #start starter script
    & $PSScriptRoot\start.ps1
}
