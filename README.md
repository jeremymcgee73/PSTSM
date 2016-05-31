# PSTSM
A PowerShell Module for IBM's Tivoli Storage Manager / Spectrum Protect

##Description
This repository contains PowerShell functions to administer IBM's TSM (Tivoli Storage Manager) / Spectrum Protect. This module does require the TSM admin client to be installed. I have tested this module on Windows 10 and TSM Client 7.1.3. This should work with older versions of TSM and windows as well.

##Getting Started
You can install this module by copying the PSTSM folder to your PowerShell Modules directory. You will need to have installed the TSM admin client before using the module. 

There are a few environmental variables that need to be set. These variables are DSM_CONFIG, DSM_DIR, and adding the DSM_DIR value to your PATH variable. The module will check to see if they are set when the module is imported. You can either set these variables by hand, or use Set-TsmEnvironmentVar.

##Functions
|  PSTSM Function  |  Description  |
| ------------- | ------------- |
| Set-TsmEnvironmentVar | Sets the Environmental variables required for the TSM client to be ran in batch mode |
| Test-TsmEnvornmentVar | Tests to see if the Environmental variables are set correctly |
| Set-TsmCredential | Stores the TSM username and password for the server connection |
| Get-TsmNode | Gets TSM nodes |
| New-TsmNode | Creates a new TSM node |
| Remove-TsmNode | Removes a TSM nodes |
| Rename-TsmNode | Renames a TSM node |
| Get-TsmAssocation | Gets TSM assocations |
| Remove-TsmAssociation | Removes TSM assocations |
| Get-TsmFilespace | Gets TSM filespaces |
| New-TsmAssociation | Creates a TSM assocation |
| Remove-TsmFilespace | Removes TSM assocations |
| Get-TsmProcess | Gets TSM processes |
| Stop-TsmProcess | Stops TSM processes |
| Get-TsmSession | Get TSM sessions |
| Stop-TsmSession | Stops TSM sessions |
| Invoke-TsmCommand | Runs a tsm command, this function is used by almost every function in the module |


##Credentials
There are two ways to set the username and password used by this module. You can pass parameters using `-Username USERNAME -Password PASSWORD`, or you can set them once with `Set-TsmCredential -Username USERNAME -Password PASSWORD`.


##Help
You can use `Get-Command -Module PSTSM` to get a list of cmdlets in the module.
You can use `Get-Help command` to view the help information for the cmdlet.

##TO DO
There are a few functions I would like to add: querying the log, granting proxy rights, etc. We do not use the archive functions of TSM, so I do not plan on creating them in PSTSM.

##Credentials
There are two ways to set the username and password used by this module. You can pass parameters using `-Username USERNAME -Password PASSWORD`, or you can set them once with `Set-TsmCredential -Username USERNAME -Password PASSWORD`.

