
Configuration DC01
{
    param 
    ( 
        [Parameter(Mandatory)] 
        [pscredential]$safemodeAdministratorCred, 
        [Parameter(Mandatory)] 
        [pscredential]$domainCred 
    ) 

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xActiveDirectory
    Import-DscResource -ModuleName xNetworking
    Import-DscResource -ModuleName xTimeZone
    Import-DscResource -ModuleName xDhcpServer
    Import-DscResource -ModuleName xComputerManagement
    Import-DscResource -ModuleName xWindowsUpdate
    Import-DscResource -ModuleName xPendingReboot
    
    node $AllNodes.NodeName
    {
        
        LocalConfigurationManager            
        {            
            ActionAfterReboot = 'ContinueConfiguration'            
            ConfigurationMode = 'ApplyOnly'
            RefreshMode = 'Push'            
            RebootNodeIfNeeded = $true            
        }

# > Begin Baseline Configuration < #

        xComputer DC01
        {
            Name = 'DC01'
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
            IPAddress = '192.168.137.200'
            InterfaceAlias = "Ethernet"
            AddressFamily = "IPv4"
        }

        xDefaultGatewayAddress DGA
        {
            Address = '192.168.137.1'
            InterfaceAlias = 'Ethernet'
            AddressFamily = 'IPV4'        
        }

        xDNSServerAddress DNS
        {
            Address = '192.168.137.1'
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
            Key = 'HKCU\Software\Microsoft\ServerManager'
            ValueName = 'DoNotOpenServerManagerAtLogon'
            ValueType = 'Dword'
            ValueData = '0'
            Force = $true
        }

        Service MapsBroker
        {
            Name = 'MapsBroker'
            State = 'Stopped'
            StartupType = 'Disabled'
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

# > Begin Roles and Features < #

        WindowsFeature ADDSInstall
        {
           Ensure = 'Present'
           Name = 'AD-Domain-Services'
        }

        xADDomain djd
        {
            DomainName = 'djd.com'
            DomainAdministratorCredential = $domainCred
            SafemodeAdministratorPassword = $safemodeAdministratorCred
            DependsOn = '[WindowsFeature]ADDSInstall'
        }

        xWaitForADDomain DscForestWait 
        { 
            DomainName = 'djd.com'
            DomainUserCredential = $domainCred 
            RetryCount = 20 
            RetryIntervalSec = 30 
            DependsOn = '[WindowsFeature]ADDSInstall'
        } 

        WindowsFeature ADDSTools
        {
            Ensure = 'Present'
            Name = 'RSAT-ADDS'
            DependsOn = '[WindowsFeature]ADDSInstall'
        }
        WindowsFeature DHCPInstall
        {
            Ensure = 'Present'
            Name = 'DHCP'
            DependsOn = '[WindowsFeature]ADDSInstall'
        }
        xDhcpServerScope DJDDeployScope
        {
            Ensure = 'Present'
            IPStartRange = '192.168.137.100'
            IPEndRange = '192.168.137.199'
            Name = 'DJD'
            SubnetMask = '255.255.255.0'
            LeaseDuration = '8'
            State = 'Active'
            DependsOn = '[WindowsFeature]DHCPInstall'
        }
    }
}

# > End Roles and Features < #

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

DC01 -ConfigurationData $ConfigData `
    -safemodeAdministratorCred (Get-Credential -UserName '(Password Only)' -Message "New Domain Safe Mode Admin Credentials") `
    -domainCred (Get-Credential -UserName 'djd\administrator' -Message "New Domain Admin Credentials") `
    -OutputPath 'C:\Setup\DC01'
    
Set-DscLocalConfigurationManager -Path 'C:\Setup\DC01' -Verbose -ComputerName localhost
Start-DscConfiguration -Path 'C:\Setup\DC01' -Wait -Force -Verbose -ComputerName localhost