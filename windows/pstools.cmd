set logFolder=sysinfo.%computername%.%date:~-15,4%-%date:~-8,2%-%date:~-5,2%
rmdir /S/Q %logFolder%
md %logFolder%

@echo off

@rem Recent Files
..\RecentFileCache\dumpBCF.exe > %logFolder%\RecentFileCache.bcf.txt


@rem this year file list
dir /a/o-d/tc c:\windows\system32 | findstr /c:"%date:~-15,4%" > %logFolder%\List.windows.system32.%date:~-15,4%.txt
dir /a/o-d/tc c:\windows\ | findstr /c:"%date:~-15,4%" > %logFolder%\List.windows.%date:~-15,4%.txt
dir /a/o-d/tc c:\windows\temp | findstr /c:"%date:~-15,4%" > %logFolder%\List.windows.temp.%date:~-15,4%.txt

@rem user file list recursive
echo %HomePath%
dir /a/o-d/tc/s/n %HomeDrive%%HomePath% | findstr /c:"%date:~-15,4%" > %logFolder%\List.User.Home.%date:~-15,4%.txt

@rem DNS Query info
ipconfig /displaydns > %logFolder%\DNSQuery.%date:~-15,4%.txt

@rem Netbios Cache Name
nbtstat -S > %logFolder%\NetbiosCacheName.%date:~-15,4%.txt

@rem Net Session
net session  > %logFolder%\NetSession.%date:~-15,4%.txt

@rem Net Session
net file  > %logFolder%\NetFile.%date:~-15,4%.txt

@rem DC User Info
net user /domain %username% > %logFolder%\NetUserInfo.txt

@rem ARP Cache
arp -a   > %logFolder%\ARPCache.%date:~-15,4%.txt

@rem Task List (PID/Process Name)
tasklist >  %logFolder%\TaskPIDList.%date:~-15,4%.txt

tasklist /svc /fi "IMAGENAME eq svchost.exe" >  %logFolder%\TaskServicePIDList.%date:~-15,4%.txt

@rem sysinternal info
..\Pstools\PsInfo.exe > %logFolder%\psinfo.txt
..\Pstools\Pslist > %logFolder%\pslist.txt


@rem Network Info Process Name and PID version
netstat -abno > %logFolder%\netstatPortAP.txt
netstat -aon > %logFolder%\netstatPortPID.txt


@rem Unsigned checked
..\sigcheck\sigcheck.exe -u -e -s -h c:\windows\system32  > %logFolder%\SignChk.ProgramFiles.txt
..\sigcheck\sigcheck.exe -u -e -s -h c:\windows\  > %logFolder%\SignChk.windows.txt


rem virus total version
rem ..\sigcheck\sigcheck.exe -u -e -s -vrs d:\temp

