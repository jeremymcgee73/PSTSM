function Test-TsmEnvironmentVar
{
    $EnvPath = (Get-ChildItem Env:PATH).value

    if(-not $EnvPath.Contains("baclient"))
    {
       throw "The environmental variable PATH does not contain the TSM client installation directory. You can manually edit your PATH variable or use Set-TsmEnvornmentVar"
    }

    if(!(Test-Path env:DSM_CONFIG))
    {
       throw "The environmental variable DSM_CONFIG does not contain the TSM client installation directory. You can manually add your DSM_CONFIG environmental variable to the path of the client option file  or use Set-TsmEnvornmentVar"
    }

    if(!(Test-Path env:DSM_DIR))
    {
        throw -Message "The environmental variable DSM_DIR does not contain the TSM client installation directory. You can manually add your DSM_CONFIG environmental variable to the path of the client mesage files are located  or use Set-TsmEnvornmentVa"
    }
}

