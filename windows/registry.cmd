REM ���ͪ� hive �ɮסA�i�ϥ� regviewer.exe �˵����e
REM https://www.gaijin.at/en/dlregview.php

set logFolder=registry.%computername%.%date:~-15,4%-%date:~-8,2%-%date:~-5,2%
rmdir /S/Q %logFolder%
md %logFolder%

@echo off

REM Save security hive to a file, �x�s Registry ������� hive �ɮ�
reg save HKLM\Security %logFolder%\security.hive  

REM Save system hive to a file
reg save HKLM\System %logFolder%\system.hive 


REM Save \Software hive to a file
reg save HKLM\Software %logFolder%\software.hive 

REM Save sam hive
reg save HKLM\SAM %logFolder%\sam.hive 