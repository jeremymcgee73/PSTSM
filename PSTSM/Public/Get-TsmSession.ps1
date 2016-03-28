<#
.Synopsis
   Gets the TSM Sessions running on a server.
.DESCRIPTION
   This cmdlet gets the TSM sessions running on a server. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   Get-TsmSession FS*
.EXAMPLE
   Get-TsmSession
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   PSCustomObject
#>
function Get-TsmSession
{
	[OutputType('System.Management.Automation.PSCustomObject')]
    Param
    (
        [Parameter(Position=0)]
		[String]$ClientName,
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
        #But, ClientName is not a parameter that it accepts so we must remove it.
        if ($PSBoundParameters['ClientName']) {
            $PSBoundParameters.Remove('ClientName') | Out-Null
        }
        $executeTSM = Invoke-TsmCommand -Command "query session" @psboundparameters
        $tsmSessionAll = ConvertFrom-Csv -Delimiter "`t" -InputObject $executeTSM -Header "SessionNumber", "CommMethod", "SessionState", "WaitTime", "BytesSent", "BytesReceived", "SessionType", "Platform", "ClientName"

        If($ClientName)
        {
            $sessions = $TsmSessionAll | Where-Object{$_.ClientName -like $ClientName}
        }
        else
        {
            $sessions = $TsmSessionAll
        }

        return $sessions

    }
    End
    {
    }
}