@rem 3389:rdp 135:msrpc
@echo Usage: classC_PortScan.cmd 3389 192.168.1
@echo off
set FileName="Port_%1_%2_Scan.txt"

echo %date% %time% > %FileName%
for /L %%i in (1,1,254) do paping -p %1 %2.%%i -c 1  | findstr protocol >> %FileName%
