<#
.Synopsis
   Gets the TSM Associations that exist on a server.
.DESCRIPTION
   This cmdlet gets the TSM Associations that exist on a server. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   Get-TsmAssociation
.EXAMPLE
   Get-TsmAssociation 
.OUTPUTS
   PSCustomObject
#>
function Get-TsmAssociation
{
	[OutputType('System.Management.Automation.PSCustomObject')]
    Param
    (
        [Parameter(Position=0)]
		[String]$PolicyDomain,
        [Parameter(Position=1)]
		[String]$SchedName,
        [Parameter(Position=2)]
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

        #We only want to set the Associationname to query, if it were passed
        $TsmAssociationCommand = "Query Association"
        If($AssociationName)
        {
            $TsmAssociationCommand = $TsmAssociationCommand + " $AssociationName"
        }
        
        try{
            $executeTSM = Invoke-TsmCommand -Command $TsmAssociationCommand @psboundparameters
            $TsmAssociations = ConvertFrom-Csv -Delimiter "`t" -InputObject $executeTSM -Header "PolicyDomain", "ScheduleName", "AssociatedNodes"
            return $TsmAssociations
        }
        catch {
            Write-Error $_
        }


    }
    End
    {
    }
}