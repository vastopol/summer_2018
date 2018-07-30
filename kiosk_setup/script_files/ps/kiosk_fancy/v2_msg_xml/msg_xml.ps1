<#	
    Kiosk script
	Loops browser with settings provided in settings.xml
	Script relies on a settings.xml file, the xml should be in same folder

	<?xml version="1.0" encoding="UTF-8"?>
	<Settings>
	<Main>
	<PRGM><string: "program"><PRGM>
	<URL><string: url></URL>
	<KIOSK><bool: True/False></KIOSK> 
    <CACHE><bool: True/False></CACHE> 
    <EKILL><bool: True/False></EKILL>
	</Main>
	</Settings>
#>

#----------------------------------------

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

#----------------------------------------


# get xml data from folder
$cur_dir = pwd
$setter = -join($cur_dir,"\settings.xml")

[xml]$ConfigFile = Get-Content $setter

if(!($ConfigFile)) 
{
    Write-Error "settings.xml not found"
}

$PRGM     = $ConfigFile.Settings.Main.PRGM
$URL      = $ConfigFile.Settings.Main.URL
$KIOSK    = $ConfigFile.Settings.Main.KIOSK 
$EKILL    = $ConfigFile.Settings.Main.EKILL

#----------------------------------------

# modify url with flags
if($KIOSK -eq 'True')
{
    $URL = -join($URL," -kiosk")
}

# kill explorer
if($EKILL -eq 'True')
{
    taskkill /f /im explorer.exe
}

#----------------------------------------

# main
while(1)
{
    Start-Process $PRGM -ArgumentList $URL -Wait
	
    PopUp-MessageBox
} 

