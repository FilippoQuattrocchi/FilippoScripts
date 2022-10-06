@echo off
netdom computername SRVDC.domain.local /add:SRVDC.newdomain.local
netdom computername SRVDC.domain.local /makeprimary:SRVDC.newdomain.local
echo Press a key to reboot
shutdown /r /t 0
