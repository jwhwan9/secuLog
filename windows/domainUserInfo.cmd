set logFolder=domainInfo.%computername%.%date:~-15,4%-%date:~-8,2%-%date:~-5,2%
rmdir /S/Q %logFolder%
md %logFolder%

@echo off

REM Domain User Account ���o�ثe DC �b����T
net user /domain %username% > %logFolder%\Current.Account.%date:~-15,4%.txt

REM Kerberos Ticket Cache
klist   > %logFolder%\KerberosTicketCache.%date:~-15,4%.txt

REM Lists all of the domain users ���o�Ҧ� DC �b��
net user /domain  > %logFolder%\Domain.User.%date:~-15,4%.txt

REM ���o�Ҧ� Domain Group �M��
net view /domain > %logFolder%\Domain.List.%date:~-15,4%.txt


REM ���o�Ҧ� Domain �U���}���� share folder ���q��(NBNS/SMB [Samba])
net view > %logFolder%\Samba.Host.%date:~-15,4%.txt

REM �C�X�Ҧ���� Local Admin �� Domain �b��
net LOCALGROUP Administrators /domain > %logFolder%\DC.Local.Admin.%date:~-15,4%.txt

REM List "Domain Admins" Group �U�Ҧ��b��
net group "Domain Admins" /domain > %logFolder%\Domain.Admin.%date:~-15,4%.txt

REM List Local Admins, ���� Admin �b��
net LOCALGROUP Administrators > %logFolder%\Local.Admin.%date:~-15,4%.txt

REM ���] DC admin �b���� administrator�A���o�b����T
net user /domain administrator > %logFolder%\administrator.Account.%date:~-15,4%.txt

REM List all DC
nltest /dclist:colatour.com.tw > %logFolder%\DC.List.%date:~-15,4%.txt

REM systeminfo | findstr /B /C:"Domain"