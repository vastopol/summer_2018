:: chrome kiosk 1
:: kills explorer to hide PC interface
:: launch chrome and wait for exit
:: on browser exit, run explorer to get interface back

@echo off

:: kill explorer
taskkill /f /im explorer.exe

:: Run Chrome in kiosk
"C:\Program Files\Google\Chrome\Application\chrome.exe" http://www.google.com -kiosk

:: Run explorer when kiosk mode is deactivated (by pressing alt+F4)
explorer.exe
