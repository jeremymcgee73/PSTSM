<#
.Synopsis
   Invoke-TsmCommand runs a command in the TSM cmd line.(dsmadmc)
.DESCRIPTION
   This command runs a command in the TSM command line and returns
   the result. The string that is returned is tab delimited.
   The command only returns data, so you will need to do know
   the headers of the columns. Also, be aware of injection
   risks with this command.
.EXAMPLE
   Invoke-TsmCommand "query session"
.EXAMPLE
   Invoke-TsmCommand -UserName tsmuser -password P@ssword -TCPServerAddress 172.16.100.5 -TCPport 39 -Command query session
#>
function Invoke-TsmCommand
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $Command,
        [string] $UserName = "",
        [string] $Password = "",
        [string] $TCPServerAddress = "",
        [int] $TCPPort = 0
    )

    Begin
    {
        $privDataUserName = $MyInvocation.MyCommand.Module.PrivateData['TsmUserName']
        $privDataPassWord = $MyInvocation.MyCommand.Module.PrivateData['TsmPassword']
        $TCPServerAddressCommand = ""
        $TCPPortCommand = ""
        $UserNameCommand = ""
        $PasswordCommand = ""
    }
    Process
    {
        #If the serveraddress or tcpport is passed, then we add that to the command.
        #I don't really need this because my server and port are set in the dsm.opt file.
        if($TCPServerAddress) {
            $TCPServerAddressCommand = "-TCPServeraddress " + $TCPServeraddress
        }

        if($TCPPort) {
            $TCPPortCommand = "-TCPPort " + $TCPPort
        }

        #I think if the password is set to generate, you may not need a password?

        #Check to see if a username and password werent passed with parameters
        if($UserName -eq "" -and $Password -eq "") {
            # If not maybe the usernaame was set in the private data field
            if($privDataUserName -ne "" -and $privDataPassWord -ne "") {
                $UserNameCommand = "-id=" + $privDataUserName
                $PasswordCommand =  "-password=" + $privDataPassWord
            }
        }
        #the username and password were passed with parameters
        else {
                $UserNameCommand = "-id=" + $UserName
                $PasswordCommand =  "-password=" + $Password
        }

        #It was a ton easier to just add the baclient folder to the path. This really should be checked for failure...
        Invoke-Expression "dsmadmc.exe $TCPServerAddressCommand $TCPPortCommand $UserNameCommand $PasswordCommand -displaymode=table -dataonly=y -tab $Command "
    }
    End
    {
    }
}