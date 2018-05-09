@echo Usage: netbiosDump.cmd 
@echo off

@rem Dump Netbios based on Current IP/Class B
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
start /B nbtscan %NetworkIP%/16 > NetBios_Dump_%NetworkIP%.txt

@rem Dump Netbios based on Current IP/Class B full
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
start /B nbtscan -f %NetworkIP%/16 > NetBios_Dump_%NetworkIP%_Full.txt

