function Get-IniFile 
{  
    param(  
        [parameter(Mandatory = $true)] [string] $filePath  
    )  
    
    $anonymous = "NoSection"
  
    $ini = @{}  
    switch -regex -file $filePath  
    {  
        "^\[(.+)\]$" # Section  
        {  
            $section = $matches[1]  
            $ini[$section] = @{}  
            $CommentCount = 0  
        }  

        "^(;.*)$" # Comment  
        {  
            if (!($section))  
            {  
                $section = $anonymous  
                $ini[$section] = @{}  
            }  
            $value = $matches[1]  
            $CommentCount = $CommentCount + 1  
            $name = "Comment" + $CommentCount  
            $ini[$section][$name] = $value  
        }   

        "(.+?)\s*=\s*(.*)" # Key  
        {  
            if (!($section))  
            {  
                $section = $anonymous  
                $ini[$section] = @{}  
            }  
            $name,$value = $matches[1..2]  
            $ini[$section][$name] = $value  
        }  
    }  

    return $ini  
}

#INI FILE NAME
$myIni = Get-IniFile .\impostazioni.ini

#Variabili
$nomeSchedaEthernet = $myIni.pc.schedaeth
$nomeSchedaWifi = $myIni.pc.schedawifi
$numeroPC = $myIni.rete.numero
$siglaSede = $myIni.pc.siglasede
$ipPrimaParte = $myIni.rete.prefissoip
$numeroGateway = $myIni.rete.gateway
$dns1 = $myIni.rete.dnsprimario
$dns2 = $myIni.rete.dnssecondario
$passwordUser = $myIni.pc.pswuser
$passwordAmministratore = $myIni.pc.pswadmin

$nomePC = -join("ZF",$siglaSede,$numeroPC)
$ipAddress = -join($ipPrimaParte,".",$numeroPC)
$gateway = -join($ipPrimaParte,".",$numeroGateway)
$dns = -join($dns1,",",$dns2)

Write-Host "IP:"$ipAddress
Write-Host "Gateway:"$gateway
Write-Host "NomePC:"$nomePC
Write-Host "DNS:"$dns
Write-Host "Password user:"$passwordUser
Write-Host "Password admin:"$passwordAmministratore
Write-Host "Nome scheda Ethernet:"$nomeSchedaEthernet
Write-Host "Nome scheda Wifi:"$nomeSchedaWifi


Write-Host "Installazione VNC"
Start-Process -NoNewWindow -FilePath .\UltraVNC_1_2_17_X64_Setup.exe -ArgumentList "/loadinf=Settings\configInstallationVNC.inf","/silent" -Wait

Write-Host "Copia configurazione"
Copy-Item -Path Settings\ultravnc.ini -Destination "$Env:Programfiles\uvnc bvba\UltraVNC\ultravnc.ini"

Write-Host "Modifica Firewall"
Set-NetFirewallRule -DisplayName vnc5800 -Profile Any
Set-NetFirewallRule -DisplayName vnc5900 -Profile Any
Set-NetFirewallRule -DisplayName winvnc.exe -Profile Any

Write-Host "Modifica Schede di rete"
Disable-NetAdapter -Name $nomeSchedaWifi -Confirm:$false
New-NetIPAddress -InterfaceAlias $nomeSchedaEthernet -IPAddress $ipAddress -PrefixLength 24
New-NetRoute -InterfaceAlias $nomeSchedaEthernet -DestinationPrefix 0.0.0.0/0 -NextHop $gateway
Set-DnsClientServerAddress -InterfaceAlias $nomeSchedaEthernet -ServerAddresses $dns

Write-Host "Modifica nome e password"
Rename-Computer -NewName $nomePC
net user User $passwordUser
net user Amministratore $passwordAmministratore
#net user Amministratore *
PAUSE
Restart-Computer -Force
