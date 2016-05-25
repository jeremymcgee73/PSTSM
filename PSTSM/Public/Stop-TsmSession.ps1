<#
.Synopsis
   Stops one or more TSM Sessions running on a server.
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
        $cancelSession = ($_.SessionNumber).replace(",","")
        $SessionNumber | ForEach-Object {
             Write-Verbose "Session " + $cancelSession + " Stopped"
             Invoke-TsmCommand -Command "cancel session $cancelSession " @psboundparameters | Out-Null
        }

    }
    End
    {
    }
}