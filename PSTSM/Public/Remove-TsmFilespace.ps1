<#
.Synopsis
   Removes one or more TSM filespaces.
.DESCRIPTION
   This function removes filespaces from TSM. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   Get-TsmFilespace DOMAIN SCHEDULE NODENAME
.EXAMPLE
   Get-TsmFilespace -PolicyDomain DOMAIN -ScheduleName SCHEDULE -NodeName NODENAME
.EXAMPLE
   Get-TsmFilespace DOMAIN SCHEDULE FS* | Remove-TsmFilespace
#>
function Remove-TsmFilespace
{
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')] 
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
		[String]$NodeName,
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
		[String]$FilespaceName,
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
        if($FilespaceName) {
            $TsmCommand = "delete filespace $NodeName $FilespaceName nametype=unicode"
        }
        else {
            $TsmCommand = "delete filespace $NodeName * nametype=unicode"
        }
      
        
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