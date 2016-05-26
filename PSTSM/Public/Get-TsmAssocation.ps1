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
   Get-TsmAssociation -PolicyDomain POLICYDOMAIN -NodeName NODENAME
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
    [CmdletBinding()] 
    param( 
        [String]$UserName,
        [String]$Password,
        [String]$TCPServerAddress,
        [int]$TCPPort,
        [Parameter(Mandatory=$true,Position=0)][String]$PolicyDomain,
        [Parameter(Mandatory=$false,Position=1)][string]$SchedName,
        [Parameter(Mandatory=$false,Position=2)][string]$NodeName
    )

    Begin
    {
        $Nodes = @()
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

            #Tivoli returns assocations with all of then nodes in one cell.
            foreach($Assoc in $TsmAssociations) {
                foreach($AssocNode in $Assoc.AssociatedNodes -split '\s+') {

                    $Node = [PSCustomObject] @{
                      PolicyDomain=$Assoc.PolicyDomain
                      ScheduleName=$Assoc.ScheduleName
                      NodeName=$AssocNode
                    }

                    $Nodes += $Node
                }          
            }

            if($NodeName) {
                Write-Output $Nodes | Where-Object {$_.NodeName -like "$NodeName"}
            }
            else {
                Write-Output $Nodes
            }
        }
        catch {
            Write-Error $_
        }

    }
    End
    {
    }
}