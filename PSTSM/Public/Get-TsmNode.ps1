<#
.Synopsis
   Gets the TSM nodes that exist on a server.
.DESCRIPTION
   This cmdlet gets the TSM sessions that exist on a server. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   Get-TsmNode FS*
.EXAMPLE
   Get-TsmSession
.OUTPUTS
   PSCustomObject
#>
function Get-TsmNode
{
	[OutputType('System.Management.Automation.PSCustomObject')]
    Param
    (
        [Parameter(Position=0)]
		[String]$NodeName,
        [Parameter(Position=1)]
		[String]$UserName,
        [Parameter(Position=2)]
		[String]$Password,
        [Parameter(Position=3)]
		[String]$TCPServerAddress,
        [Parameter(Position=4)]
		[int]$TCPPort
    )


    Begin
    {
    }
    Process
    {
        #We are using splatting to pass the parameters to Invoke-TSMCommand
        #But, NodeName is not a parameter that it accepts so we must remove it.
        if ($PSBoundParameters['NodeName']) {
            $PSBoundParameters.Remove('NodeName') | Out-Null
        }

        #We only want to set the nodename to query, if it were passed
        $TsmNodeCommand = "query node"
        If($NodeName)
        {
            $TsmNodeCommand = $TsmNodeCommand + " $NodeName"
        }

        $executeTSM = Invoke-TsmCommand -Command $TsmNodeCommand @psboundparameters
        $TsmNodes = ConvertFrom-Csv -Delimiter "`t" -InputObject $executeTSM -Header "NodeName", "Platform", "PolicyDomain", "DaysSinceLastAccess", "DaysSincePasswordSet", "Locked"


        return $TsmNodes

    }
    End
    {
    }
}