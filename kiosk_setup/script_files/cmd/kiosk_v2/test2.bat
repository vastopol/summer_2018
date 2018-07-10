:: chrome kiosk 2
:: kills explorer to hide PC interface
:: infinite loop to launch chrome in kiosk mode 
:: on browser exit will open a new window

@echo off

:: variables
set prgm="C:\Program Files\Google\Chrome\Application\chrome.exe"
set dest="https://chassintranet.ucr.edu/saas2/advisor"

:: kill explorer
taskkill /f /im explorer.exe

:: Run browser in kiosk mode infinite loop
:launch
%prgm% %dest% -kiosk 
goto launch