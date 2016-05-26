<#
.Synopsis
   Gets one to many TSM Processs.
.DESCRIPTION
   This cmdlet gets the TSM sessions that exist on a server. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   Get-TsmProcess 2356
.EXAMPLE
   Get-TsmProcess
#>
function Get-TsmProcess
{
	[OutputType('System.Management.Automation.PSCustomObject')]
    Param
    (
        [Parameter(Position=0)]
		[String]$ProcessNumber,
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

        #We only want to set the Process to query, if it were passed
        $TsmProcessCommand = "query Process"
        If($ProcessNumber)
        {
            $ProcessNumber = $ProcessNumber -replace ',',''
            $TsmProcessCommand = $TsmProcessCommand + " $ProcessNumber"
        }
        
        try{
            $executeTSM = Invoke-TsmCommand -Command $TsmProcessCommand @psboundparameters
            $TsmProcesss = ConvertFrom-Csv -Delimiter "`t" -InputObject $executeTSM -Header "ProcessNumber", "ProcessDesc", "Process Status"
            return $TsmProcesss
        }
        catch {
            Write-Error $_
        }


    }
    End
    {
    }
}