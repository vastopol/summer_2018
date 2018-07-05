# https://gist.github.com/danjpadgett/435f8b43c36d740aad55fe23c014e499

<#	
	.NOTES
	===========================================================================
	 Created by:   	Dan Padgett (C) 
	 Organization: 	www.execmgr.net
	 Filename:     	LoopIE
	 Version:     	3.0
	===========================================================================

	.SYNOPSIS
	Loops IE with settings provided in settings.xml

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

	.DISCLAIMER
	All scripts are provided AS IS without warranty of any kind. The author further disclaims all implied warranties including, without limitation, 
	any implied warranties of merchantability or of fitness for a particular purpose. 
	The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. 
	In no event shall the author,or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever
	including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss
	arising out of the use of or inability to use the sample scripts or documentation, even if the author has been advised of the possibility of such damages.

	.LINK
	www.execmgr.net


#>


[xml]$ConfigFile = Get-Content "C:\Program Files\LoopIE\Settings.xml"
if (!($ConfigFile)) {Write-Error "Settings not found"}
$kioskmode = $ConfigFile.Settings.Main.Kiosk 
$URL = $ConfigFile.Settings.Main.URL
$INTERVAL = $ConfigFile.Settings.Main.INTERVAL

if ($kioskmode -eq 'True')

    {$arguments = "-k $URL"}

    else

    {$arguments = "$URL"}



$myshell = New-Object -com "Wscript.Shell"

while  (1 -eq 1)
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

}
  Start-Sleep -s $INTERVAL
} 