[cmdletbinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory, ValueFromPipeline)][pscustomobject]$VirtualMachine,
    [switch]$NoGui
)

begin {
    switch ($NoGui) {
        $true {
            $GuiArg = "nogui"
        }

        default {
            $GuiArg = "gui"
        }
    }
}

process {
    $VmrunArgs = @{
        "FilePath"         = "vmrun";
        "ArgumentList"     = "start ""$($VirtualMachine.Path)"" $($GuiArg)";
        "WorkingDirectory" = $VirtualMachine.Location
    }

    Start-Process @VmrunArgs -NoNewWindow
}