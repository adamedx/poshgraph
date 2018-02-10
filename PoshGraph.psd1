#
# Module manifest for module 'poshgraph'
#
# Generated by: adamedx
#
# Generated on: 9/24/2017
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'poshgraph.psm1'

# Version number of this module.
ModuleVersion = '0.7.5'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '524a2b17-37b1-43c2-aa55-6c19692c6450'

# Author of this module
Author = 'Adam Edwards'

# Company or vendor of this module
CompanyName = 'Modulus Group'

# Copyright statement for this module
Copyright = '(c) 2018 Adam Edwards.'

# Description of the functionality provided by this module
Description = 'CLI for Microsoft Graph and Azure Active Directory Graph interaction'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
ScriptsToProcess = @('./src/graph.ps1')

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @(@{ModuleName='scriptclass';ModuleVersion='0.12.2';Guid='9b0f5599-0498-459c-9a47-125787b1af19'})

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @('get-graphitem', 'Test-Graph', 'Get-GraphVersion', 'new-graphconnection', 'invoke-graphrequest', 'get-graphtoken', 'get-graphschema', 'get-grapherror', 'connect-graph', 'disconnect-graph')

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @('')

# List of all files packaged with this module
FileList = @('.\poshgraph.psd1', '.\poshgraph.psm1', '.\src\cmdlets.ps1', '.\src\test-graph.ps1', '.\src\graphendpoint.ps1', '.\src\restrequest.ps1', '.\src\restresponse.ps1', '.\src\Get-GraphToken.ps1', '.\src\invoke-graphrequest.ps1', '.\src\get-graphitem.ps1', '.\src\get-graphversion.ps1', '.\src\graphapplication.ps1', '.\src\graphrequest.ps1', '.\src\graphresponse.ps1', '.\src\grapherrorrecorder.ps1', '.\src\get-graphschema.ps1', '.\src\get-graphitem.ps1', '.\src\graphidentity.ps1', '.\src\application.ps1', '.\src\new-graphconnection.ps1', '.\src\connect-graph.ps1', '.\src\disconnect-graph.ps1', '.\src\graph.ps1','.\src\GraphConnection.ps1', '.\build\install.ps1')

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('MSGraph', 'Graph')

        # A URL to the license for this module.
        LicenseUri = 'http://www.apache.org/licenses/LICENSE-2.0'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/adamedx/poshgraph'

        # A URL to an icon representing this module.
        IconUri = 'https://raw.githubusercontent.com/adamedx/poshgraph/master/assets/PoshGraphIcon.png'

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}