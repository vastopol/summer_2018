' Windows Script to set a user shell through registry
' modify key1 so system uses key3 as the logon shell instead

set wShell = CreateObject("WScript.shell")

' set up key 1 : local machine
k1_path  = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\IniFileMapping\system.ini\boot\Shell"
k1_value = "USR:Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
k1_type  = "REG_SZ"

' set up key 3 : current user
k3_path  = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell"
k3_value = "C:\Program Files\Google\Chrome\Application\chrome.exe"
k3_type  = "REG_SZ"

' write key 1
wShell.RegWrite k1_path, k1_value, k1_type

' write key 3
wShell.RegWrite k3_path, k3_value, k3_type
