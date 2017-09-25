@echo off
mkdir 

set logFolder=Raw_Evtx.%computername%.%date:~-15,4%-%date:~-8,2%-%date:~-5,2%
del /f/s %logFolder%
md %logFolder%

copy %SystemRoot%\System32\winevt\Logs\* %logFolder%