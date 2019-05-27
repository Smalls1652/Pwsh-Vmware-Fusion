[CmdletBinding()]
param(
    [string]$VmName,
    [string]$VmxFolder = "~/Virtual Machines"
)

begin {
    filter VmNameParse {
        if ($_.BaseName -like "$($VmName)*") {
            $_
        }
    }

    $VmxFolder = (Get-Item -Path $VmxFolder)

    $VmwareVmFolders = Get-ChildItem -Path $VmxFolder

    if ($VmName) {
        Write-Verbose "Parsing for specified VM."
        $VmwareVmFolders = $VmwareVmFolders | VmNameParse
    }
}

process {
    $VirtualMachines = foreach ($Vm in $VmwareVmFolders) {
        $VmxFile = Get-ChildItem -Path $Vm | Where-Object -Property "Extension" -eq ".vmx"
        [pscustomobject]@{
            "Name"     = $Vm.Name;
            "Path"     = "$($Vm.Name)/$($VmxFile.Name)";
            "Location" = $VmxFolder
        }
    }
}

end {
    $VirtualMachines
}