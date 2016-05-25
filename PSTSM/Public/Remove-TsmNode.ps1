<#
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
    Param
    (
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
        try{
            Invoke-TsmCommand -Command "Remove Node $NodeName " @psboundparameters | Out-Null
        }
        catch {
            Write-Error $_
        }
    }
    End
    {
    }
}