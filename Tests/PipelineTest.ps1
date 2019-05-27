$Vm = ../ScriptFiles/Get-VmwareVms/Get-VmwareVms.ps1 -VmName "Ubuntu"

$Vm | gm

$Vm | ../ScriptFiles/Stop-VmwareVm/Stop-VmwareVm.ps1