Write-Host "Installazione VNC"
Start-Process -NoNewWindow -FilePath .\UltraVNC_1_2_17_X64_Setup.exe -ArgumentList "/loadinf=Settings\configInstallationVNC.inf","/silent" -Wait

Write-Host "Copia configurazione"
Copy-Item -Path Settings\ultravnc.ini -Destination "$Env:Programfiles\uvnc bvba\UltraVNC\ultravnc.ini"

Write-Host "Modifica Firewall"
Set-NetFirewallRule -DisplayName vnc5800 -Profile Any
Set-NetFirewallRule -DisplayName vnc5900 -Profile Any
Set-NetFirewallRule -DisplayName winvnc.exe -Profile Any
