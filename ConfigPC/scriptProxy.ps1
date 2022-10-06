Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form

$main_form.Text = "Proxy locker"
$main_form.Width = 50
$main_form.Height = 80
$main_form.AutoSize = $true

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Vuoi aggiungere o rimuovere il proxy?"
$Label.Location = New-Object System.Drawing.Point (0.10)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(20,20)
$Button.Size = New-Object System.Drawing.Size(120,23)
$Button.Text = "Aggiungi"
$main_form.Controls.Add($Button)

$Button1 = New-Object System.Windows.Forms.Button
$Button1.Location = New-Object System.Drawing.Size(180,20)
$Button1.Size = New-Object System.Drawing.Size(120,23)
$Button1.Text = "Rimuovi"
$main_form.Controls.Add($Button1)


$Button.Add_Click(
{
    Write-Host "Aggiunta al registro"
    reg import .\Proxy\lock.reg
    $main_form.Close();
    stop-process -Id $PID
}
)

$Button1.Add_Click(
{
    Write-Host "Rimozione dal registro"
    reg import .\Proxy\unlock.reg
    $main_form.Close();
    stop-process -Id $PID
}
)

$main_form.ShowDialog()
