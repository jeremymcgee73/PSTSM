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
	[CmdletBinding(
        DefaultParameterSetName='ClientName'
	)]	
    Param
    (
		[String]$ClientName,
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