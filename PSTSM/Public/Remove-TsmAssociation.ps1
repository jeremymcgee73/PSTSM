<#
.Synopsis
   Removes one or more TSM associations.
.DESCRIPTION
   This function removes associations from TSM. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   Get-TsmAssociation DOMAIN SCHEDULE NODENAME
.EXAMPLE
   Get-TsmAssociation -PolicyDomain DOMAIN -ScheduleName SCHEDULE -NodeName NODENAME
.EXAMPLE
   Get-TsmAssociation DOMAIN SCHEDULE FS* | Remove-TsmAssociation
#>
function Remove-TsmAssociation
{
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')] 
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
		[String]$PolicyDomain,
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
		[String]$ScheduleName,
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
		[String]$NodeName,
		[String]$UserName,
		[String]$Password,
		[String]$TCPServerAddress,
		[int]$TCPPort
    )

    Begin
    {
    }
    Process
    {
        $TsmCommand = "delete association $PolicyDomain $ScheduleName $NodeName"
        try{
            if ($PSCmdlet.ShouldProcess($NodeName)) {  
                Invoke-TsmCommand -Command $TsmCommand @psboundparameters | Out-Null
            }
            else {
                Write-Host "The following TSM command will run:"
                Write-Host $TsmCommand
            }
        }
        catch {
            Write-Error $_
        }
    }
    End
    {
    }
}