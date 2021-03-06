﻿<#
.Synopsis
   Removes one or more TSM node.
.DESCRIPTION
   This function removes nodes from TSM. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   Remove-TsmNode NODENAME
.EXAMPLE
   Remove-TsmNode -NodeName NODENAME
.EXAMPLE
   Get-TsmNode FS* | Remove-TsmNode
#>
function Remove-TsmNode
{
[CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')] 
    Param
    (
        [CmdletBinding(DefaultParametersetName='None',SupportsShouldProcess=$True,ConfirmImpact='High')] 
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
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

        $TsmCommand = "Remove Node $NodeName "
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