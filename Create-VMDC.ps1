# Create DC01
$VMISO = "F:\_OSSource\WS\WindowsServer2016\en_windows_server_2016_updated_feb_2018_x64_dvd_11636692.iso"
$VMName = 'HYD-CMCB-DC01'
$VMMemory = 1024MB
$VMDiskSize = 60GB
$VMNetwork = 'CMCB'
$VMLocation = 'C:\_VMStore\CMCB'
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetwork -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose
Enable-VMIntegrationService -VMName $VMName -Name "Guest Service Interface"

# Checkpoint "Not booted"
#Checkpoint-VM -Name $VMName -SnapshotName "Not Booted"

# Start and Connect - DC01
VMConnect localhost $VMName
Start-VM -Name $VMName