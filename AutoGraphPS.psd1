#
# Module manifest for module 'AutoGraphPS'
#
# Generated by: adamedx
#
# Generated on: 9/24/2017
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'autographps.psm1'

# Version number of this module.
ModuleVersion = '0.24.0'

# Supported PSEditions
CompatiblePSEditions = @('Desktop', 'Core')

# ID used to uniquely identify this module
GUID = '524a2b17-37b1-43c2-aa55-6c19692c6450'

# Author of this module
Author = 'Adam Edwards'

# Company or vendor of this module
CompanyName = 'Modulus Group'

# Copyright statement for this module
Copyright = '(c) 2019 Adam Edwards.'

# Description of the functionality provided by this module
Description = 'CLI for automating the Microsoft Graph'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.1'

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
# ScriptsToProcess = @('')

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @(
    @{ModuleName='AutoGraphPS-SDK';ModuleVersion='0.11.1';Guid='4d32f054-da30-4af7-b2cc-af53fb6cb1b6'}
    @{ModuleName='scriptclass';ModuleVersion='0.20.1';Guid='9b0f5599-0498-459c-9a47-125787b1af19'}
)

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Find-GraphPermissions',
    'Get-Graph',
    'Get-GraphChildItem',
    'Get-GraphItemWithMetadata',
    'Get-GraphLocation',
    'Get-GraphType',
    'Get-GraphUri',
    'New-Graph',
    'Remove-Graph',
    'Set-GraphLocation',
    'Set-GraphPrompt',
    'Show-GraphHelp',
    'Update-GraphMetadata'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
    VariablesToExport = @(
        'GraphAutoPromptPreference',
        'GraphMetadataPreference',
        'GraphPromptColorPreference'
    )

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @('gcd', 'gg', 'ggu', 'ggci', 'gls', 'gwd')

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @('')

# List of all files packaged with this module
    FileList = @(
        '.\AutoGraphPS.psd1',
        '.\autographps.psm1',
        '.\src\aliases.ps1',
        '.\src\cmdlets.ps1',
        '.\src\graph.ps1',
        '.\src\client\LocationContext.ps1',
        '.\src\cmdlets\Find-GraphPermissions.ps1',
        '.\src\cmdlets\Get-Graph.ps1',
        '.\src\cmdlets\Get-GraphChildItem.ps1',
        '.\src\cmdlets\Get-GraphItemWithMetadata.ps1',
        '.\src\cmdlets\Get-GraphLocation.ps1',
        '.\src\cmdlets\Get-GraphType.ps1',
        '.\src\cmdlets\Get-GraphUri.ps1',
        '.\src\cmdlets\New-Graph.ps1',
        '.\src\cmdlets\Remove-Graph.ps1',
        '.\src\cmdlets\Set-GraphLocation.ps1',
        '.\src\cmdlets\Set-GraphPrompt.ps1',
        '.\src\cmdlets\Show-GraphHelp.ps1',
        '.\src\cmdlets\Update-GraphMetadata.ps1',
        '.\src\cmdlets\common\ContextHelper.ps1',
        '.\src\cmdlets\common\GraphParameterCompleter.ps1',
        '.\src\cmdlets\common\GraphUriParameterCompleter.ps1',
        '.\src\cmdlets\common\LocationHelper.ps1',
        '.\src\cmdlets\common\PermissionHelper.ps1',
        '.\src\cmdlets\common\SegmentHelper.ps1',
        '.\src\common\PreferenceHelper.ps1',
        '.\src\common\GraphAccessDeniedException.ps1',
        '.\src\metadata\metadata.ps1',
        '.\src\metadata\Entity.ps1',
        '.\src\metadata\EntityEdge.ps1',
        '.\src\metadata\EntityGraph.ps1',
        '.\src\metadata\EntityVertex.ps1',
        '.\src\metadata\GraphBuilder.ps1',
        '.\src\metadata\GraphCache.ps1',
        '.\src\metadata\GraphDataModel.ps1',
        '.\src\metadata\GraphManager.ps1',
        '.\src\metadata\GraphSegment.ps1',
        '.\src\metadata\SegmentParser.ps1',
        '.\src\metadata\UriCache.ps1'
    )

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('MSGraph', 'Graph', 'AADGraph', 'Azure', 'MicrosoftGraph', 'Microsoft-Graph', 'MS-Graph', 'AAD-Graph', 'GraphExplorer', 'REST', 'CRUD', 'GraphAPI', 'autograph', 'poshgraph', 'PSEdition_Core', 'PSEdition_Desktop')

        # A URL to the license for this module.
        LicenseUri = 'http://www.apache.org/licenses/LICENSE-2.0'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/adamedx/poshgraph'

        # A URL to an icon representing this module.
        IconUri = 'https://raw.githubusercontent.com/adamedx/poshgraph/master/assets/PoshGraphIcon.png'

        # Adds pre-release to the patch version according to the conventions of https://semver.org/spec/v1.0.0.html
        # Requires PowerShellGet 1.6.0 or greater
        # Prerelease = '-preview'

        # ReleaseNotes of this module
        ReleaseNotes = @"
# AutoGraphPS 0.24.0 Release Notes

## New Features

## New dependencies

AutoGraphPS-SDK 0.11.1
ScriptClass 0.20.1

## Fixed defects


"@
    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
