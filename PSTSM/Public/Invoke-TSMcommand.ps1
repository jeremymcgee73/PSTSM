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
                   Position=0)]
        $Command,
        [string] $UserName = "",
        [string] $Password = "",
        [string] $TCPServerAddress = "",
        [int] $TCPPort = 0,
        #Dummy paramter to collect unassigned parameters that are called due to splatting.
        [Parameter(ValueFromRemainingArguments = $true)]
        $Splat
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
            $TCPServerAddressCommand = "-TCPServeraddress='" + $TCPServeraddress + "'"
        }

        if($TCPPort) {
            $TCPPortCommand = "-TCPPort " + $TCPPort
        }


        #Check to see if a username and password werent passed with parameters
        if($UserName -ne "" -and $Password -ne "") {
            $UserNameCommand = "-id=" + $UserName
            $PasswordCommand =  "-password=" + $Password
        }
        #the username and password were passed with parameters
        elseif($privDataUserName -ne $null -and $privDataPassWord -ne $null) {
                $UserNameCommand = "-id=" + $privDataUserName
                $PasswordCommand =  "-password=" + $privDataPassWord
        }
        else {
            Throw "A TSM username and/or password were not given."
        }


        $TsmParams = @($TCPServerAddressCommand,$TCPPortCommand,$UserNameCommand,$PasswordCommand,"-displaymode=table","-dataonly=y","-tab",$Command)
        $TsmOutput = & dsmadmc $TsmParams  2>&1 | Out-String


        if($LASTEXITCODE -eq 0)
        {
            Write-Verbose "The following TSM command was ran:"
            Write-Verbose $Command

            Write-Output $TsmOutput
        }
        elseif($LASTEXITCODE -eq 137)
        {
            Throw "The TSM password is incorrect."
        }
        elseif($LASTEXITCODE -eq 53)
        {
            Throw "The TSM username is not incorrect."
        }
        else
        {
            $errorOut = $TsmOutput.Substring(9)
            $errorOut = ($errorOut -split '\n')[0]

            Throw $errorOut
        }
    }
    End
    {
    }
}