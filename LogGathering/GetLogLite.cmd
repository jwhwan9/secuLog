@echo off

REM set logFolder=IR.%date:~-15,4%-%date:~-8,2%%date:~-5,2%-%time:~-11,2%%time:~-8,2%.%computername%
set logFolder=IR.%date:~-15,4%-%date:~-8,2%%date:~-5,2%.%computername%
del /f/s %logFolder%
md %logFolder%
md %logFolder%\eventlog

@REM Windows Current Service
tasklist /v > %logFolder%\tasklistVerbose.txt
tasklist > %logFolder%\tasklistVerbose.txt

@REM DNS Cache
ipconfig /displaydns > %logFolder%\DisplayDNS.txt

@REM WMIC System Information
wmic /Output:"%logFolder%\bios.csv"  bios list full /Format:CSV
wmic /Output:"%logFolder%\os.csv"  os 
wmic /Output:"%logFolder%\process.csv"  process list full /Format:CSV
wmic /Output:"%logFolder%\startup.csv"  startup list full /Format:CSV
wmic /Output:"%logFolder%\service.csv"  service list full /Format:CSV
wmic /Output:"%logFolder%\share.csv"  share list full /Format:CSV
wmic /Output:"%logFolder%\computersystem.csv"  computersystem list full /Format:CSV
wmic /Output:"%logFolder%\useraccount.csv"  useraccount list full /Format:CSV
wmic /Output:"%logFolder%\QuickFixEngineering.csv"  qfe list full /Format:CSV
wmic /Output:"%logFolder%\sysaccount.csv"  sysaccount list full /Format:CSV
wmic /Output:"%logFolder%\netlogin.csv"  netlogin list full /Format:CSV
wmic /Output:"%logFolder%\nicconfig.csv"  nicconfig list full /Format:CSV
wmic /Output:"%logFolder%\nic.csv"  nic list full /Format:CSV
wmic /Output:"%logFolder%\netuse.csv"  netuse list full /Format:CSV
wmic /Output:"%logFolder%\netprotocol.csv"  netprotocol list full /Format:CSV

@REM DNS Cache
netstat -nba > %logFolder%NetstatAP.txt

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