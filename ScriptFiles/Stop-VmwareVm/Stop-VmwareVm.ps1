[cmdletbinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory, ValueFromPipeline)][pscustomobject]$VirtualMachine,
    [switch]$Hard
)

begin {
    switch ($Hard) {
        $true {
            $ResetType = "hard"
        }

        default {
            $ResetType = "soft"
        }
    }
}

process {
    $VmrunArgs = @{
        "FilePath"         = "vmrun";
        "ArgumentList"     = "stop ""$($VirtualMachine.Path)"" $($ResetType)";
        "WorkingDirectory" = $VirtualMachine.Location
    }

    Start-Process @VmrunArgs -NoNewWindow
}