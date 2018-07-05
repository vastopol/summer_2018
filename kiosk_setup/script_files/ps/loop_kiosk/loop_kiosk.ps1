<#	
	Loop Kiosk script

	.SYNOPSIS
	Loops browser with settings provided in settings.xml

	.NOTES
	Script relies on a settings.xml file , the file should look like:

		<?xml version="1.0" encoding="UTF-8"?>
        <Settings>
	    <Main>
		<URL>http://google.com</URL>
	    <KIOSK>False</KIOSK> 
		<INTERVAL><# OF SECONDS></INTERVAL> 
	    </Main>
        </Settings>
		
#>

[xml]$ConfigFile = Get-Content "C:\Program Files\LoopIE\Settings.xml"

if(!($ConfigFile)) 
{
    Write-Error "Settings not found"
}

$kioskmode = $ConfigFile.Settings.Main.Kiosk 
$URL = $ConfigFile.Settings.Main.URL
$INTERVAL = $ConfigFile.Settings.Main.INTERVAL

if($kioskmode -eq 'True')
{
    $arguments = "-k $URL"
}
else
{
    $arguments = "$URL"
}

$myshell = New-Object -com "Wscript.Shell"

while(1)
{
    $myshell = New-Object -com "Wscript.Shell"
    $myshell.sendkeys("{SCROLLLOCK}")
    $ProcessActive = Get-Process iexplore -ErrorAction SilentlyContinue
	
    if($ProcessActive -eq $null)
    {
	    Start-Process "C:\Program Files (x86)\Internet Explorer\iexplore.exe" -argumentlist $arguments
    }
    else
    {
        # nothing ???
	}
    
	Start-Sleep -s $INTERVAL
} 

