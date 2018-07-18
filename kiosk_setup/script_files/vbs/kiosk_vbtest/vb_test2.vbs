' kiosk loop with message

' run variables
sCmd1 = "taskkill /f /im explorer.exe"
sCmd2 = "chrome.exe -kiosk"
sDest = "https://chassintranet.ucr.edu/saas2/advisor"

' popup variables
sTitle = "Administrator Message"
sText  = "Do Not Close the Browser Window" & Chr(13)
sText  = sText & "The Window Will Automatically Open When Closed"
iType  = 0 + 16 + 4096  ' ok button, error icon, and force popup appear on top

Set wShell = CreateObject("wscript.shell") 

wShell.run sCmd1

' main 
Do While(1)
  wShell.run sCmd2 & " " & sDest, 1, true  ' launch chrome
  wShell.Popup sText, , sTitle, iType      ' display error message
Loop
