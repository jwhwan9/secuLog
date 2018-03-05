@echo off

set logFolder=IR.%date:~-15,4%-%date:~-8,2%%date:~-5,2%-%time:~-11,2%%time:~-8,2%.%computername%
del /f/s %logFolder%
md %logFolder%
md %logFolder%\eventlog

@REM Get All User Account
net view > %logFolder%\dcHost.txt
cscript GetDomainObject.vbs > %logFolder%\dcDomainAllObject.txt
cscript GetServer.vbs > %logFolder%\dcHostOU.txt

@REM WMIC System Information
wmic /Output:"%logFolder%\bios.csv"  bios list full /Format:CSV
wmic /Output:"%logFolder%\os.csv"  os > os.txt
wmic /Output:"%logFolder%\process.csv"  process list full /Format:CSV
wmic /Output:"%logFolder%\startup.csv"  startup list full /Format:CSV
wmic /Output:"%logFolder%\service.csv"  service list full /Format:CSV
wmic /Output:"%logFolder%\share.csv"  share list full /Format:CSV
wmic /Output:"%logFolder%\computersystem.csv"  computersystem list full /Format:CSV
wmic /Output:"%logFolder%\useraccount.csv"  useraccount list full /Format:CSV
wmic /Output:"%logFolder%\QuickFixEngineering.csv"  qfe list full /Format:CSV



@REM GET MFT
rawcopy64 %SYSTEMDRIVE%0 %logFolder%

@REM Get Registry Hive
rawcopy64 %UserProfile%\NTUSER.DAT %logFolder%

rawcopy64 %SystemRoot%\system32\config\SAM %logFolder%

rawcopy64 %SystemRoot%\system32\config\SYSTEM %logFolder%
rawcopy64 %SystemRoot%\system32\config\DEFAULT %logFolder%

rawcopy64 %SystemRoot%\system32\config\SECURITY %logFolder%
rawcopy64 %SystemRoot%\system32\config\SOFTWARE %logFolder%

rawcopy64 %LOCALAPPDATA%\Microsoft\Windows\UsrClass.dat %logFolder%


@REM Get Event Log
copy %SystemRoot%\System32\winevt\Logs\* %logFolder%\eventlog