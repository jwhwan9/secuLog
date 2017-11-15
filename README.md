# secuLog
collection of script/tools for security check 
0. Microsoft sysinternal suite
https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite

1. 是否異常程序有奇怪聯網行為
	-DOS Command: netstat -abno
	-Process Explorer Microsoft https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer
	-Process Hacker https://github.com/processhacker2/processhacker
	-CurrPorts http://www.nirsoft.net/utils/cports.html

2. 系統 Baseline 是否被改變
	-AutoRuns 相關啟動設定 Registry等，Microsoft AutoRuns: https://docs.microsoft.com/en-us/sysinternals/downloads/autoruns
	-重要系統檔案是否被改變 (Sigcheck 看檔案簽章是否異常，file hash check) Microsoft Sigcheck: https://docs.microsoft.com/en-us/sysinternals/downloads/sigcheck

3. 系統記錄
	-完整的 Eventlog dump, Microsoft wevtutil: https://technet.microsoft.com/zh-tw/library/cc732848(v=ws.11).aspx
	-最後執行檔案 (C:\Windows\AppCompat\Programs\RecentFileCache.bcf)
	
4. 系統最近運作行為
	-LastActivityView Nirsoft: http://www.nirsoft.net/utils/computer_activity_view.html
	-BrowserHistoryView Nirsoft: http://www.nirsoft.net/utils/browsing_history_view.html

