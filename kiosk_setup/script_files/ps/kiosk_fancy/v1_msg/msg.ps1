
function PopUp-MessageBox()
{
$wShell = New-Object -ComObject Wscript.Shell;
$title = "SYSTEM WARNING"
$msg = 
"
STOP, DO NOT EXIT THE BROWSER.
THIS SYSTEM IS SET UP IN SECURE KIOSK MODE.
THE BROWSER WILL AUTOMATICALLY RESPAWN WHEN CLOSED.
"

$wShell.PopUp($msg, 0, $title, 49)
}

# vars
$prgm = "chrome.exe"
$dest = "https://chassintranet.ucr.edu/saas2/advisor -kiosk"

# kill explorer
taskkill /f /im explorer.exe

# main
while(1)
{
    Start-Process $prgm -ArgumentList $dest -Wait
    PopUp-MessageBox
}
