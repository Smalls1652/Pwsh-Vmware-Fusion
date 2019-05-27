[CmdletBinding()]
param(
    [string]$VmxFolder = "~/Virtual Machines"
)

$VmwareVmFolders = Get-ChildItem -Path $VmxFolder

$VirtualMachines = foreach ($Vm in $VmwareVmFolders) {
    $VmxFile = Get-ChildItem -Path $Vm | Where-Object -Property "Extension" -eq ".vmx"
    [pscustomobject]@{
        "Name" = $Vm.BaseName;
        "Path" = $Vm.FullName;
        "VmxInfo" = ([pscustomobject]@{
            "VmxFile" = $VmxFile.Name;
            "Path" = $VmxFile.FullName
        })
    }
}

return $VirtualMachines