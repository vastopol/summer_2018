Set WshShell = WScript.CreateObject("WScript.Shell")
int Return = WshShell.Run("notepad " & WScript.ScriptFullName, 1, TRUE)
WshShell.Popup "Notepad is now closed."
