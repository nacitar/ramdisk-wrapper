[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true,
        Position=0,
        HelpMessage="The drive letter to which to mount the RAMDisk.")]
    [String]$DriveLetter,

    [Parameter(Mandatory=$true,
        Position=1,
        HelpMessage="The size of the RAMDisk, suffixed with units: b (512-byte blocks), k, m, g, t, K, M, G, or T")]
    [String]$Size,

    [Parameter(Mandatory=$false,
        Position=2,
        HelpMessage="The filesystem type to pass to the format command: ntfs, fat, fat32, ...")]
    [String]$FSType = "ntfs",

    [Parameter(Mandatory=$false,
        Position=3,
        HelpMessage="The label to use for the filesystem.")]
    [String]$FSLabel = "RAMDisk",

    [Parameter(Mandatory=$false,
        Position=4,
        HelpMessage="If specified, a Temp directory will be created within the RAMDisk.")]
    [Switch]$MakeTempDirectory,

)

$ErrorActionPreference = [Management.Automation.ActionPreference]::Stop

Import-Module -Global -Force "$PSScriptRoot\RAMDisk.psm1"

New-RAMDisk -DriveLetter $DriveLetter -Size $Size -FSType $FSType -FSLabel $FSLabel
if ($MakeTempDirectory) {
    [void](New-Item -ItemType Directory -Path "${DriveLetter}:\Temp" -Force)
}
