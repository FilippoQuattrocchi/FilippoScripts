#Declaring Variables
$var1 = "192.168.10.201"
$var2 = "8.8.8.8"
$Adapter1 = Get-NetAdapter -Physical | select -expand name 
Set-DnsClientServerAddress -InterfaceAlias $Adapter1

$Adapter1 | ForEach-Object{
    $myAdapter = $_
    "Adapter: $myAdapter" 
    netsh interface ipv4 set dnsservers name=$myAdapter static $var1 primary
    netsh interface ipv4 add dnsservers name=$myAdapter $var2 index=2
    #Set-DnsClientServerAddress -InterfaceAlias $Adapter
}
Write-Host "The Primary DNS is:" $var1
Write-Host "The Secondary DNS is:" $var2
exit