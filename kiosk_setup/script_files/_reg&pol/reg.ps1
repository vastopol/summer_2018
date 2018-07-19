<#

the key1 is supposed to be at:
HKLM:\Software\Microsoft\Windows NT\CurrentVersion\IniFileMapping\system.ini\boot\Shell

the key 3 is supposed to be at:
HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell

#>


# set up key 1 : local machine
$k1_path  = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\IniFileMapping\system.ini\boot"
$k1_name  = "Shell"
$k1_value = "USR:Software\Microsoft\Windows NT\CurrentVersion\Winlogon"


# set up key 3 : current user
$k3_path  = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
$k3_name  = "Shell"
$k3_value = "C:\Program Files\Google\Chrome\Application\chrome.exe"


# key 1
echo "old hklm shell"
Get-ItemProperty -Path $k1_path -Name $k1_name

Set-ItemProperty -Path $k1_path -Name $k1_name -Value $k1_value

echo "new hklm shell"
Get-ItemProperty -Path $k1_path -Name $k1_name


# key 2
echo "old hkcu shell"
Get-ItemProperty -Path $k3_path -Name $k3_name

Set-ItemProperty -Path $k3_path -Name $k3_name -Value $k3_value

echo "new hkcu boot shell"
Get-ItemProperty -Path $k3_path -Name $k3_name

