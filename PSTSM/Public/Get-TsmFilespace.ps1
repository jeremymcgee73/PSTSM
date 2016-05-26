<#
.Synopsis
   Gets the TSM Filespaces that exist on a server.
.DESCRIPTION
   This cmdlet gets the TSM Filespaces that exist on a server.
   If you use the SchedName parameter, you must also pass the
   policy domain parameter.
.EXAMPLE
   Get-TsmFilespace
.EXAMPLE
   Get-TsmFilespace -PolicyDomain POLICYDOMAIN -SchedName SCHEDNAME
.EXAMPLE
   Get-TsmFilespace -PolicyDomain POLICYDOMAIN
.EXAMPLE
   Get-TsmFilespace POLICYDOMAIN SCHEDNAME
.EXAMPLE
   Get-TsmFilespace POLICYDOMAIN
.OUTPUTS
   PSCustomObject
#>
function Get-TsmFilespace
{
    [CmdletBinding(DefaultParametersetName='None')] 
    param( 
        [String]$UserName,
        [String]$Password,
        [String]$TCPServerAddress,
        [int]$TCPPort,
        [Parameter(ParameterSetName='Node',Mandatory=$true,Position=0)][string]$NodeName,
        [Parameter(ParameterSetName='Node',Mandatory=$false,Position=1)][string]$FilespaceName
    )

    Begin
    {
        $Nodes = @()
    }
    Process
    {

        #The parameterset above makes sure there is a policydomain, if there is a schedname
        #But you can have a policydomain without a schedname
        $TsmFilespaceCommand = "Query Filespace"
        If($NodeName) {
            if($FilespaceName) {
                $TsmFilespaceCommand = $TsmFilespaceCommand + " $NodeName" + " $FilespaceName"  + " nametype=unicode"
            }
            else {
                $TsmFilespaceCommand = $TsmFilespaceCommand + " $NodeName"
            }
        }

        
        try{
            $executeTSM = Invoke-TsmCommand -Command $TsmFilespaceCommand @psboundparameters
            $TsmFilespaces = ConvertFrom-Csv -Delimiter "`t" -InputObject $executeTSM -Header "NodeName", "FileSpaceName", "FSID" ,"Platform","Filespace Type","Unicode?","Capacity","PctUtil"

            Write-Output $TsmFilespaces
            
        }
        catch {
            Write-Error $_
        }

    }
    End
    {
    }
}