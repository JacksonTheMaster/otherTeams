#$creds = Get-Credential 
$credspath = $Env:Programfiles+"\teamsothertenant\creds.xml"

Write-Host $credspath

Get-Credential | Export-Clixml -Path $credspath

$creds =import-clixml -path $credspath

Write-Host $creds.UserName
Write-Host $creds.Password


New-LocalUser $creds.UserName -Password $creds.Password -FullName "Teamsothertenant User" -Description "daemon f 2nd teams untl MS fixes their shit"