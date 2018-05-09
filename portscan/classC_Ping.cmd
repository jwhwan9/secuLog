@echo Usage: classC_PingScan.cmd 192.168.1
@echo off
set FileName="Ping_%1_Scan.txt"

arp -d
echo %date% %time% > %FileName%
for /L %%i in (1,1,254) do ping %1.%%i -n 1 -w 300 >> %FileName%
arp -a | find "%1" | find "°ÊºA" > IPList_%1.txt