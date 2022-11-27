Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Management.Automation


$FormObject = [System.Windows.Forms.Form]
$LabelObject = [System.Windows.Forms.Label]
$ButtonObject = [System.Windows.Forms.Button]

$form=New-Object $FormObject
$form.ClientSize='500,300'
$form.Text='OtherTeams'
$form.BackColor='#ffffff'

$labeltitle=New-Object $LabelObject
$labeltitle.Text='OtherTeams launcher'
$labeltitle.Autosize=$true
$labeltitle.Font='Verdana,20'
$labeltitle.Location=New-Object System.Drawing.Point(70,30)

$btnInstall=New-Object $ButtonObject
$btnInstall.Text='run instaler'
$btnInstall.AutoSize=$true
$btnInstall.Font='Verdana,10'
$btnInstall.BackColor='#ec0000'
$btnInstall.ForeColor='white'
$btnInstall.Location=New-Object System.Drawing.Point(175,180)

$btnStart=New-Object $ButtonObject
$btnStart.Text='Start'
$btnStart.AutoSize=$true
$btnStart.Font='Verdana,10'
$btnStart.BackColor='#acf700'
$btnStart.ForeColor='black'
$btnStart.Location=New-Object System.Drawing.Point(300,180)

$btnAddusr=New-Object $ButtonObject
$btnAddusr.Text='Add user'
$btnAddusr.AutoSize=$true
$btnAddusr.Font='Verdana,10'
$btnAddusr.BackColor='#f3db00'
$btnAddusr.ForeColor='black'
$btnAddusr.Location=New-Object System.Drawing.Point(80,180)

$form.Controls.AddRange(@($labeltitle,$btnInstall,$btnAddusr,$btnStart))




#add functionality to start button
$btnStart.Add_Click({
        $btnStart.Text='Start in 5'
        Start-Sleep -Seconds 1
        $btnStart.Text='Start in 4'
        Start-Sleep -Seconds 1
        $btnStart.Text='Start in 3'
        Start-Sleep -Seconds 1
        $btnStart.Text='Start in 2'
        Start-Sleep -Seconds 1
        $btnStart.Text='Start in 1'
        Start-Sleep -Seconds 1
        $btnStart.Text='takeoff'
        C:\Users\jakob.langisch\Documents\GitHub\Teamsothertenant\start.ps1
        $btnStart.Text='running'
    })



$btnAddusr.Add_Click({
        C:\Users\jakob.langisch\Documents\GitHub\Teamsothertenant\credmanager_gui.ps1
        $btnAddusr.Text='closing'
        Start-Sleep -Seconds 1
        $btnAddusr.Text='Add User'
    })










$form.ShowDialog()
$form.Dispose()



