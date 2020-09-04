[CmdletBinding()]
Param(
    [Parameter(
            Mandatory=$true,
            Position=0,
            HelpMessage="The drive letter of the RAMDisk to remove.")]
    [ValidateNotNullOrEmpty()]
    [String]
    $DriveLetter
)

$ErrorActionPreference = [Management.Automation.ActionPreference]::Stop

Import-Module -Global -Force "$PSScriptRoot\RAMDisk.psm1"

Remove-RAMDisk -DriveLetter $DriveLetter
