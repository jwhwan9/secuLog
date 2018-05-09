@echo Usage: netbiosScanClassB.cmd 192.168.0
@echo off
set FileName=NetBios_ClassB_%1.0.txt
nbtscan %1.0/16 > %FileName%
