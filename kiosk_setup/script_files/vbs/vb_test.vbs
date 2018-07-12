' kiosk loop with message

' run variables
sCmd  = "chrome.exe -kiosk"
sDest = "https://chassintranet.ucr.edu/saas2/advisor"

' popup variables
sTitle = "Administrator Message"
sText  = "Do Not Close the Browser Window" & Chr(13)
sText  = sText & "The Window Will Automatically Open When Closed"
iType  = 0 + 16 + 4096  ' ok button, error icon, and force popup appear on top

Set wShell = CreateObject("wscript.shell") 

sCmd2 = "taskkill /f /im explorer.exe" ' kills explorer to hide interface
wShell.run sCmd2

' main 
Do While(1)
  wShell.run sCmd, 1, true            ' launch chrome
  wShell.Popup sText, , sTitle, iType ' display error message
Loop
