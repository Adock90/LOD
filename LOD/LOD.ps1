param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("light", "dark")]
    [string]$Mode
)


function Dark {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0;
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0;
}

function Light {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 1;
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 1;
}

switch ($Mode) {
    "dark" {
        Dark
    }
    "light" {
        Light
    }
}

Write-Host "Enable Taskbar and Start menu Transprancy (N/y)";

$Input = Read-Host;

if ($Input -eq "y"){
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 1;
}
else {
    Write-Host "Would you like to Disable It (N/y)";
    $Input = Read-Host;
    if ($Input -eq "y"){
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0;
    }
}

Start-Sleep 2;

Stop-Process -Name explorer;
Start-Process explorer;

Write-Host "In order for all light and dark mode to work normally.";
Write-Host "you need to reboot the machine";
Write-Host "you can still use the Operating System but some light or dark mode on some apps may be broken but usable";
Write-Host "Do you want to reboot(N/y)";

$Input = Read-Host;

if ($Input -eq "y"){
    Write-Host "Restarting PC";
    Start-Sleep 2;
    Restart-Computer -Force;
} else {
    Exit-PSSession;
}
