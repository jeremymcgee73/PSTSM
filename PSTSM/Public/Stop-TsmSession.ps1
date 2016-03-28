<#
.Synopsis
   Stops the TSM Sessions running on a server.
.DESCRIPTION
   This cmdlet stops TSM sessions running on a server. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   Stop-TsmSession 12345
.EXAMPLE
   Get-TsmSession FS* | Stop-TsmSession
.INPUTS
   TSMSessions can be piped to Stop-TsmSession
#>
function Stop-TsmSession
{
	[OutputType('Void')]
	[CmdletBinding(
        DefaultParameterSetName='ClientName'
	)]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
		$SessionNumber,
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
        #We are using splatting to pass the parameters to Invoke-TSMCommand
        #But, SessionNumber is not a parameter that it accepts so we must remove it.
        if ($PSBoundParameters['SessionNumber']) {
            $PSBoundParameters.Remove('SessionNumber') | Out-Null
        }
        $cancelSession = ($_.SessionNumber).replace(",","")
        $SessionNumber | ForEach-Object {
             $cancelSession
             Invoke-TsmCommand -Command "canel session $cancelSession " @psboundparameters
        }

    }
    End
    {
    }
}