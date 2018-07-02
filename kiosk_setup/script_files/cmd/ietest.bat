:: kill explorer
taskkill /f /im explorer.exe

:: Run IE
"C:\Program Files\Internet Explorer\iexplore.exe" -k http://192.168.2.82:8000

:: Run explorer when kiosk mode is deactivated (by pressing alt+F4)
explorer.exe