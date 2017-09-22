@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

mkdir 

set logFolder=evtx.%computername%.%date:~-15,4%-%date:~-8,2%-%date:~-5,2%
del /f/s %logFolder%
md %logFolder%
wevtutil.exe el > %logFolder%\evtlogs.txt

for /f %%i in (%logFolder%\evtlogs.txt) do (

	for /f "tokens=1-2 delims=/" %%j in ("%%i") do ( 
		echo GetEvent: %%i	
		SET OUTPUTFILE=%%i.evtx
		IF NOT "%%k"=="" (		
			SET OUTPUTFILE=%%j-%%k.evtx
		)

		wevtutil.exe epl "%%i" %logFolder%\!OUTPUTFILE!
	)
)
