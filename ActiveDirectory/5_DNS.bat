@echo off
echo Netlogon cleared.
ipconfig /flushdns
ipconfig /registerdns
rendom /clean
net stop netlogon
echo Netlogin files deleted
del C:\Windows\System32\config\netlogon.dnb
del C:\Windows\System32\config\netlogon.dns
del C:\Windows\System32\config\netlogon.ftl
net start netlogon
echo DNS completed
PAUSE