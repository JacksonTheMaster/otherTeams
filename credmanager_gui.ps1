Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Management.Automation




#$credstore = "C:\Program Files (x86)\teamsothertenant\credstore"


$credspath = "C:\Program Files (x86)\teamsothertenant\creds.xml"
$creds =import-clixml -path $credspath
#Write-Host "_________ ....creds imported ......_________" -f Yellow
#Write-Host $creds.UserName
#Write-Host $creds.Password
$daemonuser = $creds.UserName
$daemonpasswd = $creds.Password
$daemoncreds = New-Object System.Management.Automation.PSCredential $daemonuser, $daemonpasswd


$FormObject = [System.Windows.Forms.Form]
$LabelObject = [System.Windows.Forms.Label]
$ButtonObject = [System.Windows.Forms.Button]
$ComboBoxObject = [System.Windows.Forms.ComboBox]

#base form
$AppForm=New-Object $FormObject

$AppForm=New-Object $FormObject
$AppForm.ClientSize='500,500'
$AppForm.Text='OtherTeams Cred Manager'
$AppForm.BackColor='#ffffff'


#build

$lblservice=New-Object $LabelObject
$lblservice.Text='INDEV: Cred Manager'
$lblservice.Autosize=$true
$lblservice.Font='Verdana,16'
$lblservice.Location=New-Object System.Drawing.Point(65,20)


$lblinfo_load=New-Object $LabelObject
$lblinfo_load.Text='Load creds:'
$lblinfo_load.Autosize=$true
$lblinfo_load.Font='Verdana,9'
$lblinfo_load.Location=New-Object System.Drawing.Point(30,90)

#dropdown

$dropd=New-Object $ComboBoxObject
$dropd.width='300'
$dropd.Location=New-Object System.Drawing.Point(140,90)
$dropd.Items.Add($daemonuser)




$AppForm.Controls.AddRange(@($lblservice,$dropd,$lblinfo_load))

#show
$AppForm.ShowDialog()
#trash
$AppForm.Dispose()

