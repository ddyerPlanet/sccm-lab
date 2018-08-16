
$ServicePass = (ConvertTo-SecureString -String 'P@ssw0rd!' -AsPlainText -Force)


# > Create OU Structure <#
New-ADOrganizationalUnit -Name:"HQ" -Path:"DC=djd,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"DC01.djd.com"
New-ADOrganizationalUnit -Name:"Servers" -Path:"OU=HQ,DC=djd,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"DC01.djd.com"
New-ADOrganizationalUnit -Name:"Workstations" -Path:"OU=HQ,DC=djd,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"DC01.djd.com"
New-ADOrganizationalUnit -Name:"ServiceAccounts" -Path:"OU=HQ,DC=djd,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"DC01.djd.com"
New-ADOrganizationalUnit -Name:"Users" -Path:"OU=HQ,DC=djd,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"DC01.djd.com"
New-ADOrganizationalUnit -Name:"PrivelegedUsers" -Path:"OU=HQ,DC=djd,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"DC01.djd.com"
New-ADOrganizationalUnit -Name:"Groups" -Path:"OU=HQ,DC=djd,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"DC01.djd.com"


# > Create ConfigMgr Network Access Account <#
New-ADUser -Description:"ConfigMgr Network Access Account" -Name:"SVC_CM_NA" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_CM_NA" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_CM_NA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_CM_NA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_CM_NA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_CM_NA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create ConfigMgr SRS Account <#
New-ADUser -Description:"ConfigMgr SRS Account" -Name:"SVC_CM_SRS" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_CM_SRS" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_CM_SRS,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_CM_SRS,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_CM_SRS,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_CM_SRS,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create ConfigMgr Domain Join Account <#
New-ADUser -Description:"ConfigMgr Domain Join Account" -Name:"SVC_CM_DJ" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_CM_DJ" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_CM_DJ,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_CM_DJ,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_CM_DJ,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_CM_DJ,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create ConfigMgr SQL Service Account <#
New-ADUser -Description:"ConfigMgr SQL Service Account" -Name:"SVC_CM_SQL" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_CM_SQL" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_CM_SQL,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_CM_SQL,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_CM_SQL,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_CM_SQL,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create ConfigMgr Client Push Account <#
New-ADUser -Description:"ConfigMgr Client Push Account" -Name:"SVC_CM_CP" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_CM_CP" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_CM_CP,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_CM_CP,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_CM_CP,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_CM_CP,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create System Center Installation Account <#
New-ADUser -Description:"System Center Installation Account" -Name:"SVC_SC_Install" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_SC_Install" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_SC_Install,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_SC_Install,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"SVC_SC_Install,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_SC_Install,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create OpsMgr Server Action Account <#
New-ADUser -Description:"OpsMgr Server Action Account" -Name:"SVC_OM_SA" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_OM_SA" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_OM_SA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_OM_SA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_OM_SA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_OM_SA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create OpsMgr Agent Action Account <#
New-ADUser -Description:"OpsMgr Agent Action Account" -Name:"SVC_OM_AA" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_OM_AA" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_OM_AA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_OM_AA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_OM_AA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_OM_AA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create OpsMgr Configuration Service and Data Access Account <#
New-ADUser -Description:"OpsMgr Configuration Service and Data Access Account" -Name:"SVC_OM_CSDA" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_OM_CSDA" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_OM_CSDA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_OM_CSDA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_OM_CSDA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_OM_CSDA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create OpsMgr Data Warehouse Write Account <#
New-ADUser -Description:"OpsMgr Data Warehouse Write Account" -Name:"SVC_OM_DW" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_OM_DW" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_OM_DW,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_OM_DW,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_OM_DW,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_OM_DW,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create OpsMgr Data Warehouse Read Account <#
New-ADUser -Description:"OpsMgr Data Warehouse Read Account" -Name:"SVC_OM_DR" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_OM_DR" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_OM_DR,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_OM_DR,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_OM_DR,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_OM_DR,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create OpsMgr Notification Action Account <#
New-ADUser -Description:"OpsMgr Notification Action Account" -Name:"SVC_OM_NA" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_OM_NA" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_OM_NA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_OM_NA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_OM_NA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_OM_NA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create OpsMgr SQL Server Service Account <#
New-ADUser -Description:"OpsMgr SQL Server Service Account" -Name:"SVC_OM_SQL" -Path:"OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -SamAccountName:"SVC_OM_SQL" -Server:"DC01.djd.com" -Type:"user"
Set-ADAccountPassword -Identity:"CN=SVC_OM_SQL,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=SVC_OM_SQL,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$true `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=SVC_OM_SQL,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=SVC_OM_SQL,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Create ConfigMgr Groups < #
New-ADGroup -Description:"ConfigMgr Management Point Servers" `
            -GroupCategory:"Security" `
            -GroupScope:"DomainLocal" `
            -Name:"CM_MPServers" `
            -Path:"OU=Groups,OU=HQ,DC=djd,DC=com" `
            -SamAccountName:"CM_MPServers" `
            -Server:"DC01.djd.com"

New-ADGroup -Description:"ConfigMgr Full Administrators" `
            -GroupCategory:"Security" `
            -GroupScope:"Global" `
            -Name:"CM_FullAdmins" `
            -Path:"OU=Groups,OU=HQ,DC=djd,DC=com" `
            -SamAccountName:"CM_FullAdmins" `
            -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=SVC_SC_Install,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com"} -Identity:"CN=CM_FullAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"

New-ADGroup -Description:"OpsMgr Full Administrators" `
            -GroupCategory:"Security" `
            -GroupScope:"Global" `
            -Name:"OM_FullAdmins" `
            -Path:"OU=Groups,OU=HQ,DC=djd,DC=com" `
            -SamAccountName:"OM_FullAdmins" `
            -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=SVC_SC_Install,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com"} -Identity:"CN=OM_FullAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"

New-ADGroup -Description:"Grants local admin rights on workstations" `
            -GroupCategory:"Security" `
            -GroupScope:"DomainLocal" `
            -Name:"WorkstationAdmins" `
            -Path:"OU=Groups,OU=HQ,DC=djd,DC=com" `
            -SamAccountName:"WorkstationAdmins" `
            -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=SVC_CM_CP,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com"} -Identity:"CN=WorkstationAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=SVC_OM_AA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com"} -Identity:"CN=WorkstationAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"

New-ADGroup -Description:"Grants local admin rights on servers" `
            -GroupCategory:"Security" `
            -GroupScope:"DomainLocal" `
            -Name:"ServerAdmins" `
            -Path:"OU=Groups,OU=HQ,DC=djd,DC=com" `
            -SamAccountName:"ServerAdmins" `
            -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=SVC_CM_CP,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com"} -Identity:"CN=ServerAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=SVC_OM_AA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com"} -Identity:"CN=ServerAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"

New-ADGroup -Description:"Grants local admin rights on OpsMgr servers" `
            -GroupCategory:"Security" `
            -GroupScope:"DomainLocal" `
            -Name:"OpsMgrServerAdmins" `
            -Path:"OU=Groups,OU=HQ,DC=djd,DC=com" `
            -SamAccountName:"OpsMgrServerAdmins" `
            -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=SVC_OM_CSDA,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com"} -Identity:"CN=OpsMgrServerAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=SVC_OM_DW,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com"} -Identity:"CN=OpsMgrServerAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=SVC_OM_DR,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com"} -Identity:"CN=OpsMgrServerAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=OM_FullAdmins,OU=Groups,OU=HQ,DC=djd,DC=com"} -Identity:"CN=OpsMgrServerAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"

New-ADGroup -Description:"Grants local admin rights on ConfigMgr servers" `
            -GroupCategory:"Security" `
            -GroupScope:"DomainLocal" `
            -Name:"ConfigMgrServerAdmins" `
            -Path:"OU=Groups,OU=HQ,DC=djd,DC=com" `
            -SamAccountName:"ConfigMgrServerAdmins" `
            -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=SVC_SC_Install,OU=ServiceAccounts,OU=HQ,DC=djd,DC=com"} -Identity:"CN=ConfigMgrServerAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=CM_FullAdmins,OU=Groups,OU=HQ,DC=djd,DC=com"} -Identity:"CN=ConfigMgrServerAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"

# > Create Domain Admin < #
New-ADUser -DisplayName:"Dave J. Dyer" `
           -GivenName:"Dave" `
           -Initials:"J" `
           -Name:"dyer_dave" `
           -Path:"OU=IT_Users,OU=HQ,DC=djd,DC=com" `
           -SamAccountName:"dyer_dave" `
           -Server:"DC01.djd.com" `
           -Surname:"Dyer" `
           -Type:"user"
Set-ADAccountPassword -Identity:"CN=dyer_dave,OU=IT_Users,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=dyer_dave,OU=IT_Users,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$false `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=dyer_dave,OU=IT_Users,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=dyer_dave,OU=IT_Users,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false
Set-ADGroup -Add:@{'Member'="CN=dyer_dave,OU=IT_Users,OU=HQ,DC=djd,DC=com"} -Identity:"CN=Domain Admins,CN=Users,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=admin.ddyer,OU=IT_Users,OU=HQ,DC=djd,DC=com"} -Identity:"CN=CM_FullAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADGroup -Add:@{'Member'="CN=admin.ddyer,OU=IT_Users,OU=HQ,DC=djd,DC=com"} -Identity:"CN=OM_FullAdmins,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"

# > Create ConfigMgr Admins < #
New-ADUser -DisplayName:"Dave J. Dyer" `
           -GivenName:"Dave" `
           -Initials:"J" `
           -Name:"admin.ddyer" `
           -Path:"OU=IT_Users,OU=HQ,DC=djd,DC=com" `
           -SamAccountName:"admin.ddyer" `
           -Server:"DC01.djd.com" `
           -Surname:"Dyer" `
           -Type:"user"
Set-ADAccountPassword -Identity:"CN=admin.ddyer,OU=IT_Users,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=admin.ddyer,OU=IT_Users,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$false `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=admin.ddyer,OU=IT_Users,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=admin.ddyer,OU=IT_Users,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

New-ADUser -DisplayName:"Ryan Ellison" `
           -GivenName:"Ryan" `
           -Name:"admin.rellison" `
           -Path:"OU=IT_Users,OU=HQ,DC=djd,DC=com" `
           -SamAccountName:"admin.rellison" `
           -Server:"DC01.djd.com" `
           -Surname:"Ellison" `
           -Type:"user"
Set-ADAccountPassword -Identity:"CN=admin.rellison,OU=IT_Users,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=admin.rellison,OU=IT_Users,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$false `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=admin.rellison,OU=IT_Users,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=admin.rellison,OU=IT_Users,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

New-ADUser -DisplayName:"Brock Bernatow" `
           -GivenName:"Brock" `
           -Name:"admin.bbernato" `
           -Path:"OU=IT_Users,OU=HQ,DC=djd,DC=com" `
           -SamAccountName:"admin.bbernato" `
           -Server:"DC01.djd.com" `
           -Surname:"Bernatow" `
           -Type:"user"
Set-ADAccountPassword -Identity:"CN=admin.bbernato,OU=IT_Users,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=admin.bbernato,OU=IT_Users,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$false `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=admin.ddyer,OU=IT_Users,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=admin.bbernato,OU=IT_Users,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

New-ADUser -DisplayName:"Chris Butler" `
           -GivenName:"Chris" `
           -Name:"admin.cbutler" `
           -Path:"OU=IT_Users,OU=HQ,DC=djd,DC=com" `
           -SamAccountName:"admin.cbutler" `
           -Server:"DC01.djd.com" `
           -Surname:"Butler" `
           -Type:"user"
Set-ADAccountPassword -Identity:"CN=admin.cbutler,OU=IT_Users,OU=HQ,DC=djd,DC=com" -NewPassword:$ServicePass -Reset:$true -Server:"DC01.djd.com"
Enable-ADAccount -Identity:"CN=admin.cbutler,OU=IT_Users,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"
Set-ADAccountControl -AccountNotDelegated:$false `
                     -AllowReversiblePasswordEncryption:$false `
                     -CannotChangePassword:$false `
                     -DoesNotRequirePreAuth:$false `
                     -Identity:"CN=admin.cbutler,OU=IT_Users,OU=HQ,DC=djd,DC=com" `
                     -PasswordNeverExpires:$true `
                     -Server:"DC01.djd.com" `
                     -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=admin.cbutler,OU=IT_Users,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com" -SmartcardLogonRequired:$false

# > Add Site Servers to MP Group < #
#Set-ADGroup -Add:@{'Member'="CN=MP01,OU=Servers,OU=HQ,DC=djd,DC=com", "CN=CM01,OU=Servers,OU=HQ,DC=djd,DC=com"} -Identity:"CN=CM_MPServers,OU=Groups,OU=HQ,DC=djd,DC=com" -Server:"DC01.djd.com"

<# > Create ConfigMgr GPOs < #
Import-GPO -BackupGpoName 'Configure WSUS' -Path 'C:\Setup\GPOBackups\ConfigureWSUS' -TargetName 'Configure WSUS' -CreateIfNeeded -Domain 'djd.com' -Server 'DC01.djd.com' -Verbose
New-GPLink -Name 'Configure WSUS' -Target 'OU=Servers,OU=HQ,DC=djd,DC=com' -LinkEnabled Yes -Domain 'djd.com' -Server 'DC01.djd.com' -Verbose
New-GPLink -Name 'Configure WSUS' -Target 'OU=Workstations,OU=HQ,DC=djd,DC=com' -LinkEnabled Yes -Domain 'djd.com' -Server 'DC01.djd.com' -Verbose

Import-GPO -BackupGpoName 'Workstation Local Administrators' -Path 'C:\Setup\GPOBackups\WorkstationLocalAdministrators' -TargetName 'Workstation Local Administrators' -CreateIfNeeded -Domain 'djd.com' -Server 'DC01.djd.com' -Verbose
New-GPLink -Name 'Workstation Local Administrators' -Target 'OU=Workstations,OU=HQ,DC=djd,DC=com' -LinkEnabled Yes -Domain 'djd.com' -Server 'DC01.djd.com' -Verbose

Import-GPO -BackupGpoName 'Server Local Administrators' -Path 'C:\Setup\GPOBackups\ServerLocalAdministrators' -TargetName 'Server Local Administrators' -CreateIfNeeded -Domain 'djd.com' -Server 'DC01.djd.com' -Verbose
New-GPLink -Name 'Server Local Administrators' -Target 'OU=Servers,OU=HQ,DC=djd,DC=com' -LinkEnabled Yes -Domain 'djd.com' -Server 'DC01.djd.com' -Verbose

Import-GPO -BackupGpoName 'ConfigMgr MP Servers' -Path 'C:\Setup\GPOBackups\ConfigMgrMPServers' -TargetName 'ConfigMgr MP Servers' -CreateIfNeeded -Domain 'djd.com' -Server 'DC01.djd.com' -Verbose
New-GPLink -Name 'Server Local Administrators' -Target 'OU=Servers,OU=HQ,DC=djd,DC=com' -LinkEnabled Yes -Domain 'djd.com' -Server 'DC01.djd.com' -Verbose

#>