# So powershell can run this script: Set-ExecutionPolicy RemoteSigned

$ErrorActionPreference = [Management.Automation.ActionPreference]::Stop

Import-Module -Global -Force "$PSScriptRoot\RAMDisk.psm1"

$DriveLetter = "R"
$Size = "2G"
New-RAMDisk -DriveLetter $DriveLetter -Size $Size
[void](New-Item -ItemType Directory -Path "${DriveLetter}:\Temp" -Force)