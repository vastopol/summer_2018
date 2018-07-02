:: launches chrome in kiosk mode directed to the link provided
:: timeout with a ping, then start chrome again
:: infinite loop so that if kiosk window is closed another will open

@echo off

:login
start /wait chrome.exe -kiosk https://chassintranet.ucr.edu/saas2/advisor

:continueforever
ping google.com
start /wait chrome.exe -kiosk https://chassintranet.ucr.edu/saas2/advisor
GOTO continueforever