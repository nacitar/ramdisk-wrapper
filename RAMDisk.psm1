function Test-IMDiskInstalled {
    $command = Get-Command "imdisk.exe"
    if ($command.CommandType -eq [Management.Automation.CommandTypes]::Application) {
        Write-Output $true
    } else {
        Write-Output $false
    }
}

function Test-ExitSuccess {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,
            HelpMessage="The name of the command executed.")]
        [String]$Name
    )
    if ($LASTEXITCODE -ne 0) {
        Write-Error "$Name failed with code: $LASTEXITCODE"
        return $false
    }
    return $true
}

function Remove-RAMDisk {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,
            HelpMessage="The drive letter to which to mount the RAMDisk.")]
        [String]$DriveLetter
    )
    if (!(Test-IMDiskInstalled)) {
        throw "IMDisk is not installed.  With chocolatey, install via: choco install imdisk"
    }
    & imdisk.exe -D -m "${DriveLetter}:"
    return (Test-ExitSuccess -Name "imdisk.exe")
}

function New-RAMDisk {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,
            HelpMessage="The drive letter to which to mount the RAMDisk.")]
        [String]$DriveLetter,

        [Parameter(Mandatory=$true,
            HelpMessage="The size of the RAMDisk, suffixed with units: b (512-byte blocks), k, m, g, t, K, M, G, or T")]
        [String]$Size,

        [Parameter(Mandatory=$false,
            HelpMessage="The filesystem type to pass to the format command: ntfs, fat, fat32, ...")]
        [String]$FSType = "ntfs",

        [Parameter(Mandatory=$false,
            HelpMessage="The label to use for the filesystem.  No spaces allowed.")]
        [String]$FSLabel = "RAMDisk"
    )
    if (!(Test-IMDiskInstalled)) {
        throw "IMDisk is not installed.  With chocolatey, install via: choco install imdisk"
    }
    # Could pass format args using -p, but then string parsing prevents us from having spaces in the disk label.
    & imdisk.exe -a -s $Size -m "${DriveLetter}:"
    if (Test-ExitSuccess -Name "imdisk.exe") {
        & format.com "${DriveLetter}:" "/fs:$FSType" "/v:$FSLabel" "/q" "/y"
        Write-Output (Test-ExitSuccess -Name "format.com")
    } else {
        Write-Output $false
    }
}

Export-ModuleMember -Function Remove-RAMDisk
Export-ModuleMember -Function New-RAMDisk