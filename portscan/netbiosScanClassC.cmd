@echo Usage: netbiosScanClassC.cmd 192.168.0
@echo off
set FileName=NetBios_ClassC_%1.0.txt
nbtscan %1.0/24 > %FileName%
