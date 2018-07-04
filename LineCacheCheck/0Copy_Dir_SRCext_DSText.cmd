REM for /r %1 %%i in (*.%2) do  copy "%%i" "%%~ni.%3"

for /r %1 %%i in (*.*) do  copy "%%i" "%%~ni.jpg"