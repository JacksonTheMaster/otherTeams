$credstore = "C:\Program Files (x86)\teamsothertenant\credstore"
$var = foreach($file in Get-ChildItem $credstore){

import-clixml
Write-Host "_________ ....creds imported ......_________" -f Yellow
Write-Host $creds.UserName
Write-Host $creds.Password



}
Write-Host "end of loop"
Write-Host $var[0]