<#
.Synopsis
   Creates a new TSM Assocation.
.DESCRIPTION
   This function creates a new Assocation. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are using. 
.EXAMPLE
   New-TsmAssociation PolicyDomain SchedName NODENAME
.EXAMPLE
   New-TsmAssociation -PolicyDomain PolicyDomain -SchedName SCHEDNAME -NodeName NODENAME
#>
function New-TsmAssociation
{
    Param
    (
        [Parameter(Mandatory=$true,Position=0)]
		[String]$PolicyDomain,
        [Parameter(Mandatory=$true,Position=1)]
		[String]$SchedName,
        [Parameter(Mandatory=$true,Position=2)]
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
        try{
            Invoke-TsmCommand -Command "define association $PolicyDomain $SchedName $NodeName" @psboundparameters | Out-Null
        }
        catch {
            Write-Error $_
        }
    }
    End
    {
    }
}