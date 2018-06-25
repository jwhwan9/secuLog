@REM IR_Post_Gen.cmd <Hive_Folder>
@REM Required tool:
@REM AppCompatCacheParser.exe <https://github.com/EricZimmerman/AppCompatCacheParser/releases>
@REM QWinEvent.exe
@REM RegFileExport.exe <https://www.nirsoft.net/utils/registry_file_offline_export.html>

SET IR_Target=%1

@REM Export file execution time to CSV
AppCompatCacheParser.exe --csv "%IR_Target%" -t -f "%IR_Target%\SYSTEM"


@REM Export DEFAULT Registry Hive
RegFileExport.exe "%IR_Target%\DEFAULT" "%IR_Target%\DEFAULT.reg.txt"

@REM Export NTUSER.DAT Registry Hive
RegFileExport.exe "%IR_Target%\NTUSER.DAT" "%IR_Target%\NTUSER.DAT.reg.txt"

@REM Export SAM Registry Hive
RegFileExport.exe "%IR_Target%\SAM" "%IR_Target%\SAM.reg.txt"

@REM Export SECURITY Registry Hive
RegFileExport.exe "%IR_Target%\SECURITY" "%IR_Target%\SECURITY.reg.txt"

@REM Export SOFTWARE Registry Hive
RegFileExport.exe "%IR_Target%\SOFTWARE" "%IR_Target%\SOFTWARE.reg.txt"

@REM Export SYSTEM Registry Hive
RegFileExport.exe "%IR_Target%\SYSTEM" "%IR_Target%\SYSTEM.reg.txt"

@REM Export UsrClass.dat Registry Hive
RegFileExport.exe "%IR_Target%\UsrClass.dat"  "%IR_Target%\UsrClass.dat.reg.txt"

@REM Export IR Log:Account Activity
QWinEvent.exe "%IR_Target%\eventlog\Security.evtx" > "%IR_Target%\Security.Event.csv"

