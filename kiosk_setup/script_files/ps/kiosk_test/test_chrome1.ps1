# vars
$dest = "https://chassintranet.ucr.edu/saas2/advisor -kiosk"
$prgm = "chrome.exe"

# kill explorer
taskkill /f /im explorer.exe

# main
Start-Process $prgm -ArgumentList $dest -Wait -WindowStyle Minimized

# restart explorer
Start-Process explorer.exe