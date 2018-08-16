Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name xComputerManagement
Install-Module -Name xDNSServer
Install-Module -Name xNetworking
Install-Module -Name xPendingReboot
Install-Module -Name xSQLServer
Install-Module -Name xStorage
Install-Module -Name xTimeZone
Install-Module -Name xDSCDomainJoin

Configuration CM01
{
    Param 
    ( 
        [pscredential] $domainCred
    ) 

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xActiveDirectory
    Import-DscResource -ModuleName xNetworking
    Import-DscResource -ModuleName xTimeZone
    Import-DscResource -ModuleName xDhcpServer
    Import-DscResource -ModuleName xComputerManagement
    Import-DscResource -ModuleName xWindowsUpdate
    Import-DscResource -ModuleName xPendingReboot
    Import-DscResource -ModuleName xStorage
    Import-DscResource -ModuleName xDSCDomainJoin
    
    node $AllNodes.NodeName
    {
        
        LocalConfigurationManager          
        {            
            ActionAfterReboot = 'ContinueConfiguration'            
            ConfigurationMode = 'ApplyOnly'
            RefreshMode = 'Push'            
            RebootNodeIfNeeded = $True          
        }

# > Begin Baseline Configuration < #

        xComputer CM01
        {
            Name = 'CM01'
        }

        xPendingReboot Reboot1
        {
            Name = 'After Name Change'
        }

        xTimeZone MST
        {
            IsSingleInstance = 'Yes'
            TimeZone = "Mountain Standard Time"
        }
        
        xIPAddress localIP
        {
            IPAddress = '192.168.137.201'
            InterfaceAlias = 'Ethernet'
            AddressFamily = 'IPv4'
        }

        xDefaultGatewayAddress DGA
        {
            Address = '192.168.137.1'
            InterfaceAlias = 'Ethernet'
            AddressFamily = 'IPV4'        
        }

        xDNSServerAddress DNS
        {
            Address = '192.168.137.200', '8.8.8.8'
            InterfaceAlias = 'Ethernet'
            AddressFamily = 'IPV4'
        }
        
        Registry DisableShutdownTracking
        {
            Ensure = 'Present'
            Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Reliability'
            ValueName = 'ShutdownReasonOn'
            ValueData = '0'
            ValueType = 'Dword'
            Force = $true
        }

        Registry DisableServerManagerStartup
        {
            Ensure = 'Present'
            Key = 'HKEY_LOCAL_MACHINE\Software\Microsoft\ServerManager'
            ValueName = 'DoNotOpenServerManagerAtLogon'
            ValueType = 'Dword'
            ValueData = '1'
            Force = $true
        }

        Service MapsBroker
        {
            Name = 'MapsBroker'
            State = 'Stopped'
            StartupType = 'Manual'
        }

        File CMTrace
        {
            SourcePath = 'C:\Setup\CMTrace.exe'
            DestinationPath = 'C:\Windows'
            Type = 'File'
            Ensure = 'Present'
        }

        File BGInfo
        {
            SourcePath = 'C:\Setup\BGInfo\BGInfo'
            DestinationPath = 'C:\Program Files\BGInfo'
            Recurse = $true
            Type = 'Directory'
            Ensure = 'Present'
        }

        File BGLink
        {
            SourcePath = 'C:\Setup\BGInfo\Bginfo.lnk'
            DestinationPath = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp'
            Type = 'File'
            Ensure = 'Present'
        }

# > End Baseline Configuration < #

# > Begin Disk Configuration < #

        xWaitForDisk wDisk1
        {
            DiskId = 1
            RetryCount = 10
            RetryIntervalSec = 6
        }

        xDisk iDisk1
        {
            DiskId = 1
            DriveLetter = 'E'
            FSLabel = 'ProgramFiles'
            DependsOn = "[xWaitForDisk]wDisk1"
        }

        xWaitForDisk wDisk2
        {
            DiskId = 2
            RetryCount = 10
            RetryIntervalSec = 6
        }

        xDisk iDisk2
        {
            DiskId = 2
            DriveLetter = 'F'
            FSLabel = 'SQLDB'
            DependsOn = "[xWaitForDisk]wDisk2"
        }

        xWaitForDisk wDisk3
        {
            DiskId = 3
            RetryCount = 10
            RetryIntervalSec = 6
        }

        xDisk iDisk3
        {
            DiskId = 3
            DriveLetter = 'G'
            FSLabel = 'TempDB'
            DependsOn = "[xWaitForDisk]wDisk3"
        }

        xWaitForDisk wDisk4
        {
            DiskId = 4
            RetryCount = 10
            RetryIntervalSec = 6
        }

        xDisk iDisk4
        {
            DiskId = 4
            DriveLetter = 'H'
            FSLabel = 'SQLDBLogs'
            DependsOn = "[xWaitForDisk]wDisk4"
        }

        xWaitForDisk wDisk5
        {
            DiskId = 5
            RetryCount = 10
            RetryIntervalSec = 6
        }

        xDisk iDisk5
        {
            DiskId = 5
            DriveLetter = 'I'
            FSLabel = 'ContentLibrary'
            DependsOn = "[xWaitForDisk]wDisk5"
        }

        xPendingReboot Reboot2
        {
            Name = 'AfterDiskConfig'
        }

# > End Disk Configuration < #

# > Begin ConfigMgr Prereq Configuration < #

        # Site System Prereqs
        WindowsFeature NETFrameworkCore
        {
            Name = 'NET-Framework-Core'
            Ensure = 'Present'
            IncludeAllSubFeature = $True
            Source = 'D:\Sources\sxs'
        }

        WindowsFeature RemoteDifferentialCompression
        {
            Name = 'RDC'
            Ensure = 'Present'
        }

        # Management Point Prereqs
        WindowsFeature ISAPI
        {
            Name = 'Web-ISAPI-Ext'
            Ensure = 'Present'
        }

        WindowsFeature WinAuthoring
        {
            Name = 'Web-Windows-Auth'
            Ensure = 'Present'
        }

        WindowsFeature Metabase
        {
            Name = 'Web-Metabase'
            Ensure = 'Present'
        }

        WindowsFeature WMICompat
        {
            Name = 'Web-WMI'
            Ensure = 'Present'
        }

        WindowsFeature BackgroundIntTransfer
        {
            Name = 'BITS'
            Ensure = 'Present'
        }

        # WSUS Management Feature
        WindowsFeature ASPNET
        {
            Name = 'NET-Framework-45-ASPNET'
            Ensure = 'Present'
        }
        WindowsFeature WSUS
        {
            Name = 'UpdateServices-Services'
            Ensure = 'Present'
            IncludeAllSubFeature = $true
        }
        WindowsFeature WSUSUI
        {
            Name = 'UpdateServices-RSAT'
            Ensure = 'Present'
            IncludeAllSubFeature = $true
        }

        xPendingReboot Reboot3
        {
            Name = 'AfterPrereqInstalls'
        }

# > End ConfigMgr Prereq Configuration < #
        # > Join Domain < #
        xDSCDomainjoin djdJoin
        {
            Domain = "djd.com"
            Credential = $domainCred
            JoinOU = "OU=Servers,OU=HQ,DC=djd,DC=com"
            DependsOn = '[xComputer]OM01'
        }

        xPendingReboot Reboot4
        {
            Name = 'AfterDomainJoin'
        }
    }
}

# Configuration Data            
$ConfigData = @{             
             
    AllNodes = @(             
        @{             
            Nodename = 'localhost'             
            RetryCount = 20              
            RetryIntervalSec = 30            
            PSDscAllowPlainTextPassword = $True
            PSDscAllowDomainUser = $True            
        }
    )
                      
}       

CM01 -ConfigurationData $ConfigData `
    -OutPutPath 'C:\Setup\CM01' `
    -domainCred (Get-Credential -UserName 'djd\administrator' -Message "Domain Admin Credentials")

Set-DscLocalConfigurationManager -Path 'C:\Setup\CM01' -Verbose -ComputerName localhost
Start-DscConfiguration -Path 'C:\Setup\CM01' -Wait -Force -Verbose -ComputerName localhost