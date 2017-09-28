set hr=%TIME: =0%
set hr=%hr:~0,2%
set min=%TIME:~3,2%
set SRCFolder=C:\Windows\System32\winevt\Logs
set DSTRoot=D:\XSec
set DSTFolder=D:\XSec\EvtLog
set TargetFile=%computername%-%date:~0,4%%date:~5,2%%date:~8,2%_%hr%%min%

xcopy %SRCFolder% %DSTFolder%\ /S/D/Y

7z a "%DSTRoot%\%TargetFile%" "%DSTFolder%\*"


