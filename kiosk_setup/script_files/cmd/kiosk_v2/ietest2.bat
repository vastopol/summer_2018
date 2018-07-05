:: chrome kiosk
:: kills explorer to hide PC interface
:: launch chrome and wait for exit, on close will open a new window

:: variables
set prgm="C:\Program Files\Google\Chrome\Application\chrome.exe"
set dest="https://chassintranet.ucr.edu/saas2/advisor"

:: kill explorer
taskkill /f /im explorer.exe

:: Run browser in kiosk mode infinite loop
:launch
%prgm% %dest% -kiosk 
goto launch
