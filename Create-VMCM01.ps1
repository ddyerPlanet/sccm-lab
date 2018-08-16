# Create CM01
#dibsurf# $VMISO = "C:\_OSSource\WindowsServer2016\en_windows_server_2016_x64_dvd_9718492.iso"
$VMISO = "F:\_OSSource\WS\WindowsServer2016\en_windows_server_2016_updated_feb_2018_x64_dvd_11636692.iso"
$VMName = 'HYD-CMCB-CMTP'
$VMMemory = 4096MB
$VMSysDiskSize = 100GB
$VMProgDiskSize = 100GB
$VMSQLDBDiskSize = 300GB
$VMTempDBDiskSize = 100GB
$VMDBLogsDiskSize = 150GB
$VMContentDiskSize = 500GB
$VMNetwork = 'NetNat'
$VMLocation = 'D:\_VMStoreBlind\DJDTP'

# Create VM
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetwork -Path $VMLocation -NoVHD -Verbose
Set-VMProcessor -VMName $VMName -Count 2
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

# Create VHDs
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMSysDiskSize -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk2.vhdx" -SizeBytes $VMProgDiskSize -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk3.vhdx" -SizeBytes $VMSQLDBDiskSize -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk4.vhdx" -SizeBytes $VMTempDBDiskSize -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk5.vhdx" -SizeBytes $VMDBLogsDiskSize -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk6.vhdx" -SizeBytes $VMContentDiskSize -Verbose

# Add disk to VM
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk2.vhdx" -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk3.vhdx" -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk4.vhdx" -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk5.vhdx" -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk6.vhdx" -Verbose

# Enable Guest Services
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose
Enable-VMIntegrationService -VMName $VMName -Name "Guest Service Interface"

# Checkpoint "Not booted"
# Checkpoint-VM -Name $VMName -SnapshotName "Not Booted"

# Start and Connect - CM01
VMConnect localhost $VMName
Start-VM -Name $VMName