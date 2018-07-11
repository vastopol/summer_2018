' kiosk loop

Set wShell = CreateObject("wscript.shell") 

strCmd = "chrome.exe -kiosk"

int i = 0 ' start
int j = 2 ' end

Do While (i < j)
  int ret = wShell.run(strCmd, 2, true)
  wShell.Popup "Do Not Close the Browser Window"
  i = i + 1
Loop
