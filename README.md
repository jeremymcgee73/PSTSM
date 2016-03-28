# PSTSM
A PowerShell Module for IBM's Tivoli Storage Manager / Spectrum Protect

##Description
This repository contains PowerShell cmdlets to administer IBM's TSM (Tivoli Storage Manager) / Spectrum Protect. This module does require the TSM client to be installed. I have tested this module on Windows 10 and TSM Client 7.1.3. I do think this will work with older versions.

##Getting Started
You can install this module by copying the PSTSM folder to your PowerShell Modules directory. You will need to have installed the TSM client before using the module. 

There are a few environmental variables that need to be set. These variables are DSM_CONFIG,DSM_DIR, and adding the DSM_DIR to your PATH variable. The module will check to see if they are set when imported. You can either set these variables by hand, or use Set-TsmEnvironmentVar.ps1.

##Credentials
There are two ways to set the username and password used by cmdlets. You can pass parameters using `-username USERNAME -password PASSWORD` or you can set them once with `Set-TsmCredential -TsmUserName username -TsmPassword password`. I do think I need to change how the password is stored.


##Help
You can use `Get-Command -Module PSTSM` to get a list of cmdlets in the module.
You can use `Get-Help command` to view the help information for the cmdlet.

##TO DO
I have just started working on this. I only have a few cmdlets implemented so far.  We do not use the archive functions of TSM, so I do not plan on creating them in PSTSM.