<#
.Synopsis
   Renames the TSM nodes that exist on a server.
.DESCRIPTION
   This cmdlet Renames the TSM sessions that exist on a server. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   Rename-TsmNode FS*
.EXAMPLE
   Rename-TsmSession
.OUTPUTS
   PSCustomObject
#>
function Rename-TsmNode
{
    param( 
        [String]$UserName,
        [String]$Password,
        [String]$TCPServerAddress,
        [int]$TCPPort,
        [Parameter(Mandatory=$true,Position=0)][string]$CurrentNodeName,
        [Parameter(Mandatory=$true,Position=1)][string]$NewNodeName
    )

    Begin
    {
    }
    Process
    {

        #We only want to set the nodename to query, if it were passed
        $TsmNodeCommand = "Rename node $CurrentNodeName $NewNodeName"
        
        try{
            $executeTSM = Invoke-TsmCommand -Command $TsmNodeCommand @psboundparameters
            return $TsmNodes
        }
        catch {
            Write-Error $_
        }


    }
    End
    {
    }
}