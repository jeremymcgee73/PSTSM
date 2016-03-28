<#
.Synopsis
   Sets the username and password variables for dsmadmc to run from powershell.
.DESCRIPTION
   The Set-TsmCredential is used to store the username and password for dsmadmc to run as.
   This allows you to not have to pass the username and password everytime.
.EXAMPLE
   Set-TsmCredential username password
.EXAMPLE
   Set-TsmCredential -TsmUserName username -TsmPassword password
#>
function Set-TsmCredential
{
     [cmdletbinding(SupportsShouldProcess=$False)]


    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $TsmUserName,
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        $TsmPassword
    )


    Process
    {
        $MyInvocation.MyCommand.Module.PrivateData['TsmUserName'] = $TsmUserName
        $MyInvocation.MyCommand.Module.PrivateData['TsmPassword'] = $TsmPassword
    }
}