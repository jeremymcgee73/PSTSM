<#
.Synopsis
   Gets the TSM Associations that exist on a server.
.DESCRIPTION
   This cmdlet gets the TSM Associations that exist on a server.
   If you use the SchedName parameter, you must also pass the
   policy domain parameter.
.EXAMPLE
   Get-TsmAssociation
.EXAMPLE
   Get-TsmAssociation -PolicyDomain POLICYDOMAIN -SchedName SCHEDNAME
.EXAMPLE
   Get-TsmAssociation -PolicyDomain POLICYDOMAIN
.EXAMPLE
   Get-TsmAssociation POLICYDOMAIN SCHEDNAME
.EXAMPLE
   Get-TsmAssociation POLICYDOMAIN
.OUTPUTS
   PSCustomObject
#>
function Get-TsmAssociation
{
    [CmdletBinding(DefaultParametersetName='None')] 
    param( 
		    [String]$UserName,
		    [String]$Password,
		    [String]$TCPServerAddress,
		    [int]$TCPPort,
        [Parameter(ParameterSetName='Policy',Mandatory=$true,Position=0)][String]$PolicyDomain,
        [Parameter(ParameterSetName='Policy',Mandatory=$false,Position=1)][string]$SchedName
    )

    Begin
    {
    }
    Process
    {

        #The parameterset above makes sure there is a policydomain, if there is a schedname
        #But you can have a policydomain without a schedname
        $TsmAssociationCommand = "Query Association"
        If($PolicyDomain) {
            if($SchedName) {
                $TsmAssociationCommand = $TsmAssociationCommand + " $PolicyDomain" + " $SchedName"
            }
            else {
                $TsmAssociationCommand = $TsmAssociationCommand + " $PolicyDomain"
            }
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