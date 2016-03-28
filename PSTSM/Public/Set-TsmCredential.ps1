<#
.Synopsis
   Sets the required environmental variables for dsmadmc to run from powershell.
.DESCRIPTION
   The Set-TsmEnvironmentVar sets the environment variables required for dsadmac
   and subsequently this module as well. This command defaults to the default
   path location for both the dsm.opt and the path to baclient. The script appends
   the BaclientPath to your path env variable and sets the env variable DSM_CONFIG
   and DSM_DIR.
.EXAMPLE
   Set-TsmEnvironmentVar
.EXAMPLE
   Set-TsmEnvironmentVar -BaclientPath "C:\Program Files\Tivoli\TSM\baclient" -DsmOptFilePath "C:\Program Files\Tivoli\TSM\baclient\dsm.opt"
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