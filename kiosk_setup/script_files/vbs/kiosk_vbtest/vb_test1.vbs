' var
sCmd1 = "taskkill /f /im explorer.exe"
sCmd2 = "chrome.exe -kiosk"
sDest = "https://chassintranet.ucr.edu/saas2/advisor"

Set wShell = CreateObject("wscript.shell") 

wShell.run sCmd1

' main
Do While(1)
  wShell.run sCmd2 & " " & sDest, 1, true
Loop