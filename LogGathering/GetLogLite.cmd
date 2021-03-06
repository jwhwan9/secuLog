﻿@echo off

REM set logFolder=IR.%date:~-15,4%-%date:~-8,2%%date:~-5,2%-%time:~-11,2%%time:~-8,2%.%computername%
set logFolder=IR.%date:~-15,4%-%date:~-8,2%%date:~-5,2%.%computername%
del /f/s %logFolder%
md %logFolder%
md %logFolder%\eventlog
md %logFolder%\etl
md %logFolder%\tasks
md %logFolder%\debug



@REM Netbios Name
nbtstat -c >  %logFolder%\NetBiosCache.txt
nbtstat -s >  %logFolder%\NetBiosSession.txt
nbtstat -n >  %logFolder%\NetBiosName.txt

@REM Logon sessions
query user /server:%COMPUTERNAME% > %logFolder%\QuerySession.txt

@REM C:\Windows\debug\netlogon.log

Nltest /DBFlag:2080FFFF
net stop netlogon
net start netlogon

Nltest /DBFlag:0x0
net stop netlogon
net start netlogon

copy %SystemRoot%\AppCompat\Programs\RecentFileCache.bcf %logFolder%\

@REM GPO Logon/Logoff script 
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Group Policy" /s %logFolder%\GPO_LogonScript.reg

@rem Dump Netbios based on Current IP/Class B
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
start /B nbtscan %NetworkIP%/16 > %logFolder%\NetBios_Dump_%NetworkIP%.txt


@rem Get (USB) Driver Installed log file
copy %SystemRoot%\inf\*.log %logFolder%\

@rem ETL file by ETLParser
copy %SystemRoot%\ProgramData\Microsoft\Windows\Power Efficiency Diagnostics\energy-ntkl.etl %logFolder%\etl
copy %SystemRoot%\Panther\setup.etl %logFolder%\etl
xcopy %SystemRoot%\System32\wdi %logFolder%\etl /Y
xcopy %SystemRoot%\System32\wdi\LogFiles %logFolder%\etl /Y
xcopy %SystemRoot%\System32\LogFiles\WMI %logFolder%\etl /Y
xcopy %USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer %logFolder%\etl /Y
xcopy "%ProgramData%\Microsoft\Windows\Power Efficiency Diagnostics" %logFolder%\etl /Y
xcopy %SystemRoot%\debug %logFolder%\debug /Y

xcopy "%SystemRoot%\tasks" %logFolder%\tasks /Y

@rem Stored Credential
wmic netuse get UserName /value > %logFolder%\storedCredential.txt

@rem Dump Netbios based on Current IP/Class B full
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
start /B nbtscan -f %NetworkIP%/16 > %logFolder%\NetBios_Dump_%NetworkIP%_Full.txt

@REM Domain User Group
echo --net group /domain-- > %logFolder%\NetDomainAccount.txt
net group /domain >>  %logFolder%\NetDomainAccount.txt

echo --net user /domain-- >> %logFolder%\NetDomainAccount.txt
net user /domain >>  %logFolder%\NetDomainAccount.txt

echo --net group "Domain Admins" /DOMAIN-- >> %logFolder%\NetDomainAccount.txt
net group "Domain Admins" /DOMAIN >>  %logFolder%\NetDomainAccount.txt

echo --net accounts /domain-- >> %logFolder%\NetDomainAccount.txt
net accounts /domain > %logFolder%\NetDomainAccount.txt

echo --net user-- > %logFolder%\NetAccount.txt
net user >> %logFolder%\NetAccount.txt

echo --net localgroup administrators-- >> %logFolder%\NetAccount.txt
net localgroup administrators >> %logFolder%\NetAccount.txt

echo --net accounts-- >> %logFolder%\NetAccount.txt
net accounts >> %logFolder%\NetAccount.txt

echo --net user securityadmin-- >> %logFolder%\NetAccount.txt
net user securityadmin >> %logFolder%\NetAccount.txt

@REM Dump GPO Result
gpresult /x %logFolder%\gpresult.xml
gpresult /h %logFolder%\gpresult.html
gpresult /z %logFolder%\gpresultZ.txt

@REM File Create Information
dir C:\ProgramData /S /O-D /tc /q > %logFolder%\Dir_TC_ProgramData.txt
start /B dir C:\Users /S /O-D /tc /q > %logFolder%\Dir_TC_Users.txt
dir "C:\Program Files" /S /O-D /tc /q > %logFolder%\Dir_TC_ProgramFiles.txt
dir "C:\Program Files (x86)" /S /O-D /tc /q > %logFolder%\Dir_TC_ProgramFilesx86.txt
start /B dir C:\Windows /S /O-D /tc /q > %logFolder%\Dir_TC_Windows.txt
dir C:\Temp /S /O-D /tc /q > %logFolder%\Dir_TC_Temp.txt
start /B dir C:\ /O-D /tc /q > %logFolder%\Dir_TC_C.txt
dir C:\ /AH /O-D /tc /q > %logFolder%\Dir_TC_Hidden.txt

@REM File Modify Information
dir C:\ProgramData /S /O-D /tw /q > %logFolder%\Dir_TW_ProgramData.txt
start /B dir C:\Users /S /O-D /tw /q > %logFolder%\Dir_TW_Users.txt
dir "C:\Program Files" /S /O-D /tw /q > %logFolder%\Dir_TW_ProgramFiles.txt
dir "C:\Program Files (x86)" /S /O-D /tw /q > %logFolder%\Dir_TW_ProgramFilesx86.txt
start /B dir C:\Windows /S /O-D /tw /q > %logFolder%\Dir_TW_Windows.txt
dir C:\Temp /S /O-D /tw /q > %logFolder%\Dir_TW_Temp.txt
dir C:\ /O-D /tw /q > %logFolder%\Dir_TW_C.txt
start /B dir C:\ /AH /O-D /tw /q > %logFolder%\Dir_TW_Hidden.txt

@REM System Information
systeminfo > %logFolder%\Systeminfo.txt

@rem Export Autoruns
Autorunsc.exe /accepteula -a * -c -h -s '*' > %logFolder%\Autoruns.csv

@REM Get Unsigned EXE，DLL in c:\windows
sigcheck.exe -c -s -u c:\windows\*.exe > %logFolder%\WindowsUnsignedEXE.txt
sigcheck.exe -c -s -u c:\windows\*.dll > %logFolder%\WindowsUnsignedDLL.txt

@REM MSFT Native Backdoor Check
echo %date% %time% > %logFolder%\MSFT_Native_Backdoor_Check.txt
sigcheck.exe -s c:\windows\*sethc.exe >> %logFolder%\MSFT_Native_Backdoor_Check.txt
sigcheck.exe -s c:\windows\*Utilman.exe >> %logFolder%\MSFT_Native_Backdoor_Check.txt
sigcheck.exe -s c:\windows\*osk.exe >> %logFolder%\MSFT_Native_Backdoor_Check.txt
sigcheck.exe -s c:\windows\*Narrator.exe >> %logFolder%\MSFT_Native_Backdoor_Check.txt
sigcheck.exe -s c:\windows\*Magnify.exe >> %logFolder%\MSFT_Native_Backdoor_Check.txt
sigcheck.exe -s c:\windows\*AtBroker.exe >> %logFolder%\MSFT_Native_Backdoor_Check.txt
sigcheck.exe -s c:\windows\*explorer.exe >> %logFolder%\MSFT_Native_Backdoor_Check.txt
sigcheck.exe -s c:\windows\*displayswitch.exe >> %logFolder%\MSFT_Native_Backdoor_Check.txt
sigcheck.exe -s c:\windows\*cmd.exe >> %logFolder%\MSFT_Native_Backdoor_Check.txt

@REM Net User Account Information
net user %UserName% /domain > %logFolder%\Account_%UserName%_Info.txt
net localgroup "Administrators" > %logFolder%\Account_LocalAdmins_Info.txt

@REM Windows Current Service
tasklist /v > %logFolder%\tasklistVerbose.txt
tasklist > %logFolder%\tasklistVerbose.txt
tasklist /SVC > %logFolder%\taskSVC.txt

@REM Schedule Job
schtasks /query /v /fo CSV > %logFolder%\scheduleTasks.csv

@REM DNS Cache
ipconfig /displaydns > %logFolder%\DisplayDNS.txt

@REM Web Visit Log
Weblog /scomma %logFolder%\weblog.csv /sort "Visit Time"

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
wmic /Output:"%logFolder%\InstalledAppList.csv"  product list full /Format:CSV

@REM Net Logon
echo =====[nltest /dclist:%UserDOMAIN% %logFolder%\NetlogonDCList.txt] >> %logFolder%\NetlogonDCList.txt
nltest  /dclist:%UserDOMAIN% >> %logFolder%\NetlogonDCList.txt

echo =====[nltest /whowill:%USERDOMAIN% %USERNAME%] >> %logFolder%\NetlogonDCList.txt
nltest /whowill:%USERDOMAIN% %USERNAME% >> %logFolder%\NetlogonDCList.txt

echo =====[nltest /server:%COMPUTERNAME% /sc_query:%USERDOMAIN%] >> %logFolder%\NetlogonDCList.txt
nltest /server:%COMPUTERNAME% /sc_query:%USERDOMAIN% >> %logFolder%\NetlogonDCList.txt

echo =====[nltest /server:%LogonServer%  /sc_query:%USERDOMAIN%]
nltest /server:%LogonServer%  /sc_query:%USERDOMAIN% >> %logFolder%\NetlogonDCList.txt

@REM Logon User List
echo =====[qwinsta] > %logFolder%\Logonuser.txt
qwinsta >> %logFolder%\Logonuser.txt

echo =====[whoami /priv] >> %logFolder%\Logonuser.txt
whoami /priv >> %logFolder%\Logonuser.txt

echo =====[whoami /all] >> %logFolder%\Logonuser.txt
whoami /all >> %logFolder%\Logonuser.txt

echo =====[net users]  >> %logFolder%\Logonuser.txt
net users  >> %logFolder%\Logonuser.txt

echo =====[net user %USERNAME% /domain] >> %logFolder%\Logonuser.txt
net user %USERNAME% /domain >> %logFolder%\Logonuser.txt

echo =====[net localgroup Administrators] >> %logFolder%\Logonuser.txt
net localgroup Administrators >> %logFolder%\Logonuser.txt

echo =====[cmdkey /list] >> %logFolder%\Logonuser.txt
cmdkey /list >> %logFolder%\Logonuser.txt

@REM Service Information
echo ===== [sc query] > %logFolder%\ServiceInfo.txt
sc query >> %logFolder%\ServiceInfo.txt


@REM DNS Cache
netstat -nba > %logFolder%\NetstatAP.txt
netstat -fba > %logFolder%\NetstatFQDN.txt

@REM GET MFT
rawcopy64 %SYSTEMDRIVE%0 %logFolder%

@REM Get Registry Hive
rawcopy64 %UserProfile%\NTUSER.DAT %logFolder%

rawcopy64 %SystemRoot%\system32\config\SAM %logFolder%

rawcopy64 %SystemRoot%\system32\config\SYSTEM %logFolder%
rawcopy64 %SystemRoot%\system32\config\DEFAULT %logFolder%

rawcopy64 %SystemRoot%\system32\config\SECURITY %logFolder%
rawcopy64 %SystemRoot%\system32\config\SOFTWARE %logFolder%

rawcopy64  %SystemRoot%\AppCompat\Programs\RecentFileCache.bcf %logFolder%

rawcopy64 %LOCALAPPDATA%\Microsoft\Windows\UsrClass.dat %logFolder%

AppCompatCacheParser.exe  -s %logFolder% -t

@REM Get Event Log
copy %SystemRoot%\System32\winevt\Logs\* %logFolder%\eventlog