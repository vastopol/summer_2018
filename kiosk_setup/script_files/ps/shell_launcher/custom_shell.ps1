<# 
custom shell launcher

usage:
    .\custom_shell.ps1 <USERNAME> <EXECUTABLE>

command line arguments:
    1. USERNAME of a local account
    2. EXECUTABLE to use as the custom shell

requirements:
    Windows 10 Enterprise or Windows 10 Education.	
#>

#----------------------------------------

# FUNCTIONS:

# Check if shell launcher license is enabled
function Check-ShellLauncherLicenseEnabled()
{
    [string]$source = @"
using System;
using System.Runtime.InteropServices;

static class CheckShellLauncherLicense
{
    const int S_OK = 0;

    public static bool IsShellLauncherLicenseEnabled()
    {
        int enabled = 0;

        if(NativeMethods.SLGetWindowsInformationDWORD("EmbeddedFeature-ShellLauncher-Enabled", out enabled) != S_OK) 
		{
            enabled = 0;
        }

        return (enabled != 0);
    }

    static class NativeMethods
    {
        [DllImport("Slc.dll")]
        internal static extern int SLGetWindowsInformationDWORD([MarshalAs(UnmanagedType.LPWStr)]string valueName, out int value);
    }
}
"@
    $type = Add-Type -TypeDefinition $source -PassThru
    return $type[0]::IsShellLauncherLicenseEnabled()
}

# retrieve the SID for a user account on a machine
function Get-UsernameSID($AccountName) 
{
    $NTUserObject = New-Object System.Security.Principal.NTAccount($AccountName)
    $NTUserSID = $NTUserObject.Translate([System.Security.Principal.SecurityIdentifier])
    return $NTUserSID.Value
}

#----------------------------------------

# check if license is enabled
[bool]$result = $false
$result = Check-ShellLauncherLicenseEnabled
"`nShell Launcher license enabled is set to " + $result
if(-not($result))
{
    "`nThis device doesn't have required license to use Shell Launcher"
    exit
}

# parameter error checking
if($args.length -ne 2)
{
    echo "Error: incorrect number of arguments"
	echo "Usage: .\custom_shell.ps1 <USERNAME> <EXECUTABLE>"
	exit
}

# default variables
$COMPUTER = "localhost"
$NAMESPACE = "root\standardcimv2\embedded"

# user entered variables
[string]$USER_NAME  = $args[0]
[string]$EXECUTABLE = $args[1]

echo "user: $USER_NAME"
echo "app : $EXECUTABLE"

# Create a handle to the class instance so we can call the static methods.
try 
{
    $ShellLauncherClass = [wmiclass]"\\$COMPUTER\${NAMESPACE}:WESL_UserSetting"
}
catch [Exception] 
{
    write-host $_.Exception.Message; 
    write-host "Make sure Shell Launcher feature is enabled"
    exit
}

# Security Identifiers (SID)
$Admins_SID = "S-1-5-32-544"            #BUILTIN\Administrators group
$USER_SID = Get-UsernameSID($USER_NAME)

# Define actions to take when the shell program exits.
$restart_shell   = 0
$restart_device  = 1
$shutdown_device = 2

# Sets the command prompt as the default shell, and restarts the device if the command prompt is closed. 
$ShellLauncherClass.SetDefaultShell("cmd.exe", $restart_device)

# Display the default shell to verify that it was added correctly.
$DefaultShellObject = $ShellLauncherClass.GetDefaultShell()
"`nDefault Shell is set to " + $DefaultShellObject.Shell + " and the default action is set to " + $DefaultShellObject.defaultaction

# Set Explorer as the shell for administrators.
$ShellLauncherClass.SetCustomShell($Admins_SID, "explorer.exe")

# Set EXECUTABLE as the shell for USER, and restart the machine if EXECUTABLE is closed.
$ShellLauncherClass.SetCustomShell($USER_SID, $EXECUTABLE, ($null), ($null), $restart_shell)

# View all the custom shells defined.
"`nCurrent settings for custom shells:"
Get-WmiObject -namespace $NAMESPACE -computer $COMPUTER -class WESL_UserSetting | Select Sid, Shell, DefaultAction

# Enable Shell Launcher
$ShellLauncherClass.SetEnabled($TRUE)
$IsShellLauncherEnabled = $ShellLauncherClass.IsEnabled()
"`nEnabled is set to " + $IsShellLauncherEnabled.Enabled

<#

# Remove the new custom shells.
$ShellLauncherClass.RemoveCustomShell($Admins_SID)
$ShellLauncherClass.RemoveCustomShell($USER_SID)

# Disable Shell Launcher
$ShellLauncherClass.SetEnabled($FALSE)
$IsShellLauncherEnabled = $ShellLauncherClass.IsEnabled()
"`nEnabled is set to " + $IsShellLauncherEnabled.Enabled

#>
