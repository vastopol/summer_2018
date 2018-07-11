:: chrome kiosk 3
:: kills explorer to hide PC interface
:: infinite loop to launch chrome in kiosk mode 
:: on browser exit will open a new window

@echo off

:: variables
set prgm=chrome.exe
set dest=https://chassintranet.ucr.edu/saas2/advisor

:: kill explorer
taskkill /f /im explorer.exe

:: Run browser in kiosk mode infinite loop
:launch
start /wait %prgm% -kiosk %dest% 
goto launch
