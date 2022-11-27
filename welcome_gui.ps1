Add-Type -AssemblyName System.Windows.Forms

$FormObject = [System.Windows.Forms.Form]
$LabelObject = [System.Windows.Forms.label]

$HelloworldForm = New-Object $FormObject
$HelloworldForm.ClientSize='500,300'
$HelloworldForm.Text='Hello world'
$HelloworldForm.BackColor='#ffffff'

$HelloworldForm.ShowDialog()
$HelloworldForm.Dispose()