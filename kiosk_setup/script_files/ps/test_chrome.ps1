# test script to run a chrome kiosk
# must close all open chrome browser windows first
# else it will keep opening new tabs in current the browser

# vars
$destination="https://chassintranet.ucr.edu/saas2/advisor"

# functions
function launchChrome($dest)
{
    Start-Process chrome.exe $dest -Wait -WindowStyle Hidden
}

# main
while(1)
{
    launchChrome($destination)
}