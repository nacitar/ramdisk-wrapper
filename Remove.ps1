# So powershell can run this script: Set-ExecutionPolicy RemoteSigned

$ErrorActionPreference = [Management.Automation.ActionPreference]::Stop

Import-Module -Global -Force "$PSScriptRoot\RAMDisk.psm1"

$DriveLetter = "R"
Remove-RAMDisk -DriveLetter $DriveLetter