set logFolder=domainInfo.%computername%.%date:~-15,4%-%date:~-8,2%-%date:~-5,2%
rmdir /S/Q %logFolder%
md %logFolder%

@echo off

REM Domain User Account 取得目前 DC 帳號資訊
net user /domain %username% > %logFolder%\Current.Account.%date:~-15,4%.txt

REM Kerberos Ticket Cache
klist   > %logFolder%\KerberosTicketCache.%date:~-15,4%.txt

REM Lists all of the domain users 取得所有 DC 帳號
net user /domain  > %logFolder%\Domain.User.%date:~-15,4%.txt

REM 取得所有 Domain Group 清單
net view /domain > %logFolder%\Domain.List.%date:~-15,4%.txt


REM 取得所有 Domain 下有開網路 share folder 的電腦(NBNS/SMB [Samba])
net view > %logFolder%\Samba.Host.%date:~-15,4%.txt

REM 列出所有具備 Local Admin 的 Domain 帳號
net LOCALGROUP Administrators /domain > %logFolder%\DC.Local.Admin.%date:~-15,4%.txt

REM List "Domain Admins" Group 下所有帳號
net group "Domain Admins" /domain > %logFolder%\Domain.Admin.%date:~-15,4%.txt

REM List Local Admins, 本機 Admin 帳號
net LOCALGROUP Administrators > %logFolder%\Local.Admin.%date:~-15,4%.txt

REM 假設 DC admin 帳號為 administrator，取得帳號資訊
net user /domain administrator > %logFolder%\administrator.Account.%date:~-15,4%.txt

REM List all DC
nltest /dclist:colatour.com.tw > %logFolder%\DC.List.%date:~-15,4%.txt

REM systeminfo | findstr /B /C:"Domain"