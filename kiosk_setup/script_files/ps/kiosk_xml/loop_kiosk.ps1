<#	
    Kiosk script
	Loops browser with settings provided in settings.xml
	Script relies on a settings.xml file, the xml should be in same folder

	<?xml version="1.0" encoding="UTF-8"?>
	<Settings>
	<Main>
	<URL><string: url></URL>
	<KIOSK><bool: True/False></KIOSK> 
	<INTERVAL><int: # seconds></INTERVAL> 
	</Main>
	</Settings>

    note:
	  interval has to be greater than or equal to 1 second to give window enough time
      to pop up and cover anything visible. eg: the terminal
#>

# get xml from folder
$cur_dir = pwd
$setter = -join($cur_dir,"\settings.xml")

[xml]$ConfigFile = Get-Content $setter

if(!($ConfigFile)) 
{
    Write-Error "Settings not found"
}

$kioskmode = $ConfigFile.Settings.Main.Kiosk 
$URL = $ConfigFile.Settings.Main.URL
$INTERVAL = $ConfigFile.Settings.Main.INTERVAL

if($kioskmode -eq 'True')
{
    $arguments = "$URL -kiosk"
}
else
{
    $arguments = "$URL"
}

$prgm = "C:\Program Files\Google\Chrome\Application\chrome.exe"

$myshell = New-Object -com "Wscript.Shell"

# kill explorer
taskkill /f /im explorer.exe

while(1)
{
    $myshell = New-Object -com "Wscript.Shell"
    $myshell.sendkeys("{SCROLLLOCK}")
    $ProcessActive = Get-Process chrome -ErrorAction SilentlyContinue
	
    if($ProcessActive -eq $null)
    {
	    Start-Process $prgm -ArgumentList $arguments
	}
	
	Start-Sleep -s $INTERVAL
} 

