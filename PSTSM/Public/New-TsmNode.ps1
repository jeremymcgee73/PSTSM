<#
.Synopsis
   Creates a new TSM node.
.DESCRIPTION
   This function creates new nodes. The default
   server is the connection set in your opt file. You can also choose
   which TSM server you are querying. 
.EXAMPLE
   New-TsmNode NODENAME PASSWORD DOMAIN
.EXAMPLE
   New-TsmNode -NodeName NODENAME -Password PASSWORD -Domain DOMAIN
#>
function New-TsmNode
{
    Param
    (
        [Parameter(Mandatory=$true,Position=0)]
		[String]$NodeName,
        [Parameter(Mandatory=$true,Position=1)]
		[String]$NodePassword,
        [Parameter(Mandatory=$true,Position=2)]
		[String]$NodeDomain,
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
        Invoke-TsmCommand -Command "Register Node $NodeName $NodePassword domain=$NodeDomain" @psboundparameters
    }
    End
    {
    }
}