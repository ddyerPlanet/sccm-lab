
 Configuration LCM
 {
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    
    LocalConfigurationManager          
    {            
        RefreshMode = 'Disabled'       
    }
}
LCM -OutPutPath 'C:\Setup\LCM'

Set-DscLocalConfigurationManager -Path 'C:\Setup\LCM' -Verbose -ComputerName localhost
