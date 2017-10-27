set logFolder=wmi.%computername%.%date:~-15,4%-%date:~-8,2%-%date:~-5,2%
rmdir /S/Q %logFolder%
md %logFolder%

@echo off

@rem BIOS Info
wmi bios > %logFolder%\Bios.%date:~-15,4%.txt

@rem ���o�Ұʸ��
wmic startup > %logFolder%\Startup.%date:~-15,4%.txt

@rem ���o OS �򥻸��
wmic os > %logFolder%\OSinfo.%date:~-15,4%.txt


@rem ���o process, exe, parameter ���
wmic process get caption,executablepath,commandline > %logFolder%\ProcessExe.%date:~-15,4%.txt


@rem ���o�w�� Hard Drive���
wmic logicaldisk where drivetype=3 get name, freespace, systemname, filesystem, size, volumeserialnumber >  %logFolder%\HardDisk.%date:~-15,4%.txt

@rem ���o�Ҧ� DC �b�������T
wmic useraccount >  %logFolder%\DCuserAccount.%date:~-15,4%.txt
wmic useraccount get /ALL >  %logFolder%\DCuserAccount_Detailed.%date:~-15,4%.txt

@rem ���o�����Ҧ� share folder
wmic share get /ALL >  %logFolder%\ShareFolder.%date:~-15,4%.txt

@rem ���o�Ұʪ��{���M��
wmic startup list full  > %logFolder%\StartupFullList.%date:~-15,4%.txt