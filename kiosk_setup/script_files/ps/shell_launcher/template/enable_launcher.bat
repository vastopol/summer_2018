:: Enable Shell Launcher using DISM
:: https://docs.microsoft.com/en-us/windows-hardware/customize/enterprise/shell-launcher

:: 1. Open a command prompt with administrator privileges.

:: 2. Copy install.wim to a temporary folder on hard drive (in the following steps, we'll assume it's called C:\wim).

:: 3. Create a new directory.
md c:\wim

:: 4. Mount the image.
dism /mount-wim /wimfile:c:\bootmedia\sources\install.wim /index:1 /MountDir:c:\wim

:: 5. Enable the feature.
dism /image:c:\wim /enable-feature /all /featureName:Client-EmbeddedShellLauncher

:: 6. Commit the change.
dism /unmount-wim /MountDir:c:\wim /Commit