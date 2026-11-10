
Connect-MgGraph `
-TenantId $TenantId `
-ClientSecretCredential $Credential

###################################################
# PROJECT : EntraID-AppRegistration-Lab
# FILE    : 05-Test-GraphConnection.ps1
# AUTHOR  : Julio TIOGOUO TEMZENETCHOU
#
# OBJECTIVE :
# Authenticate to Microsoft Graph using
# App Registration credentials and export
# Entra ID users.
###################################################

#==================================================
# VARIABLES
#==================================================

$TenantId = "VOTRE-TENANT-ID"

$ClientId = "VOTRE-CLIENT-ID"

$ClientSecret = "VOTRE-CLIENT-SECRET"


#==================================================
# CONVERT SECRET TO SECURE STRING
#==================================================

$SecureSecret = ConvertTo-SecureString `
$ClientSecret `
-AsPlainText `
-Force


#==================================================
# CREATE CLIENT SECRET CREDENTIAL
#==================================================

$ClientSecretCredential = `
New-Object `
System.Management.Automation.PSCredential `
($ClientId,$SecureSecret)


#==================================================
# CONNECT TO MICROSOFT GRAPH
#==================================================

Connect-MgGraph `
-TenantId $TenantId `
-ClientSecretCredential $ClientSecretCredential


#==================================================
# DISPLAY CONNECTION INFORMATION
#==================================================

Get-MgContext


#==================================================
# GET USERS
#==================================================

$Users = Get-MgUser -All


#==================================================
# EXPORT USERS
#==================================================

$Users |
Select-Object `
DisplayName,
UserPrincipalName,
AccountEnabled |
Export-Csv `
-Path ".\Reports\GraphUsers.csv" `
-NoTypeInformation `
-Encoding UTF8


#==================================================
# END
#==================================================

Write-Host "Export completed successfully"
