<#	
    Kiosk script
	Loops browser with settings provided in settings.xml
	Script relies on a settings.xml file, the xml should be in same folder

	<?xml version="1.0" encoding="UTF-8"?>
	<Settings>
	<Main>
	<PNAME><string: name></PNAME>
	<PRGM><string: program><PRGM>
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
    Write-Error "settings.xml not found"
}

$PNAME = $ConfigFile.Settings.Main.PNAME
$PRGM = $ConfigFile.Settings.Main.PRGM
$URL = $ConfigFile.Settings.Main.URL
$KIOSK = $ConfigFile.Settings.Main.KIOSK 
$INTERVAL = $ConfigFile.Settings.Main.INTERVAL

if($KIOSK -eq 'True')
{
    $URL = -join($URL," -kiosk")
}

# kill explorer
taskkill /f /im explorer.exe

while(1)
{
    $myshell = New-Object -com "Wscript.Shell"
    $myshell.sendkeys("{SCROLLLOCK}")
    $ProcessActive = Get-Process $PNAME -ErrorAction SilentlyContinue
	
    if($ProcessActive -eq $null)
    {
        Start-Process $PRGM -ArgumentList $URL
    }
	
	Start-Sleep -s $INTERVAL
} 

