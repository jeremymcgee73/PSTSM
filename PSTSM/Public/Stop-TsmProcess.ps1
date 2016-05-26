<#
.Synopsis
   Stops one or more TSM Processs running on a server.
.DESCRIPTION
   This cmdlet stops TSM Processs running on a server. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   Stop-TsmProcess 12345
.EXAMPLE
   Get-TsmProcess 12345 | Stop-TsmProcess
.INPUTS
   TSMProcesss can be piped to Stop-TsmProcess
#>
function Stop-TsmProcess
{
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
		$ProcessNumber,
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
        $ProcessNumber = ($_.ProcessNumber).replace(",","")
            
        try{
            Invoke-TsmCommand -Command "cancel Process $ProcessNumber" @psboundparameters | Out-Null
        }
        catch {
            Write-Error $_
        }
        
    }
    End
    {
    }
}