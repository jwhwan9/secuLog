set logFolder=wmi.%computername%.%date:~-15,4%-%date:~-8,2%-%date:~-5,2%
rmdir /S/Q %logFolder%
md %logFolder%

@echo off

@rem BIOS Info
wmi bios > %logFolder%\Bios.%date:~-15,4%.txt

@rem 取得啟動資料
wmic startup > %logFolder%\Startup.%date:~-15,4%.txt

@rem 取得 OS 基本資料
wmic os > %logFolder%\OSinfo.%date:~-15,4%.txt


@rem 取得 process, exe, parameter 資料
wmic process get caption,executablepath,commandline > %logFolder%\ProcessExe.%date:~-15,4%.txt


@rem 取得硬碟 Hard Drive資料
wmic logicaldisk where drivetype=3 get name, freespace, systemname, filesystem, size, volumeserialnumber >  %logFolder%\HardDisk.%date:~-15,4%.txt

@rem 取得所有 DC 帳號完整資訊
wmic useraccount >  %logFolder%\DCuserAccount.%date:~-15,4%.txt
wmic useraccount get /ALL >  %logFolder%\DCuserAccount_Detailed.%date:~-15,4%.txt

@rem 取得本機所有 share folder
wmic share get /ALL >  %logFolder%\ShareFolder.%date:~-15,4%.txt

@rem 取得啟動的程式清單
wmic startup list full  > %logFolder%\StartupFullList.%date:~-15,4%.txt