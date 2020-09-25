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
ModuleVersion = '0.33.0'

# Supported PSEditions
CompatiblePSEditions = @('Desktop', 'Core')

# ID used to uniquely identify this module
GUID = '524a2b17-37b1-43c2-aa55-6c19692c6450'

# Author of this module
Author = 'Adam Edwards'

# Company or vendor of this module
CompanyName = 'Modulus Group'

# Copyright statement for this module
Copyright = '(c) 2020 Adam Edwards.'

# Description of the functionality provided by this module
Description = 'CLI for automating and exploring the Microsoft Graph'

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
FormatsToProcess = @('./src/cmdlets/common/AutoGraphFormats.ps1xml')

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @(
    @{ModuleName='autographps-sdk';ModuleVersion='0.23.0';Guid='4d32f054-da30-4af7-b2cc-af53fb6cb1b6'}
    @{ModuleName='scriptclass';ModuleVersion='0.20.2';Guid='9b0f5599-0498-459c-9a47-125787b1af19'}
    @{ModuleName='ThreadJob';ModuleVersion='2.0.3';Guid='0e7b895d-2fec-43f7-8cae-11e8d16f6e40'}
)

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
    'Add-GraphRelatedItem',
    'Find-GraphPermission',
    'Get-Graph',
    'Get-GraphChildItem',
    'Get-GraphItem',
    'Get-GraphItemRelationship',
    'Get-GraphRelatedItem',
    'Get-GraphItemUri',
    'Get-GraphResourceWithMetadata',
    'Get-GraphLocation',
    'Get-GraphType',
    'Get-GraphUri',
    'Get-GraphUriInfo',
    'Invoke-GraphMethod',
    'New-Graph',
    'New-GraphItem',
    'New-GraphItemRelationship',
    'New-GraphMethodParameterObject',
    'New-GraphObject',
    'Remove-Graph',
    'Remove-GraphItem',
    'Remove-GraphItemRelationship',
    'Set-GraphItem',
    'Set-GraphLocation',
    'Set-GraphPrompt',
    'Show-GraphHelp',
    'Update-GraphMetadata'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = @(
    'GraphAutoPromptPreference'
    'GraphMetadataPreference'
    'GraphPromptColorPreference'
    'GraphVerboseOutputPreference' # From AutoGraphPS-SDK
    'LastGraphItems'               # From AutoGraphPS-SDK
)

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = @('gcd', 'gg', 'ggci', 'ggi', 'ggu', 'gls', 'gwd')

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @('')

# List of all files packaged with this module
    FileList = @(
        '.\autographps.psd1',
        '.\autographps.psm1',
        '.\src\aliases.ps1',
        '.\src\cmdlets.ps1',
        '.\src\graph.ps1',
        '.\src\client\LocationContext.ps1',
        '.\src\cmdlets\Add-GraphRelatedItem.ps1',
        '.\src\cmdlets\Find-GraphPermission.ps1',
        '.\src\cmdlets\Get-Graph.ps1',
        '.\src\cmdlets\Get-GraphChildItem.ps1',
        '.\src\cmdlets\Get-GraphItem.ps1',
        '.\src\cmdlets\Get-GraphItemRelationship.ps1',
        '.\src\cmdlets\Get-GraphItemUri.ps1',
        '.\src\cmdlets\Get-GraphLocation.ps1',
        '.\src\cmdlets\Get-GraphRelatedItem.ps1',
        '.\src\cmdlets\Get-GraphResourceWithMetadata.ps1',
        '.\src\cmdlets\Get-GraphType.ps1',
        '.\src\cmdlets\Get-GraphUri.ps1',
        '.\src\cmdlets\Get-GraphUriInfo.ps1',
        '.\src\cmdlets\Invoke-GraphMethod.ps1',
        '.\src\cmdlets\New-Graph.ps1',
        '.\src\cmdlets\New-GraphItem.ps1',
        '.\src\cmdlets\New-GraphItemRelationship.ps1',
        '.\src\cmdlets\New-GraphMethodParameterObject.ps1',
        '.\src\cmdlets\New-GraphObject.ps1',
        '.\src\cmdlets\Remove-Graph.ps1',
        '.\src\cmdlets\Remove-GraphItem.ps1',
        '.\src\cmdlets\Remove-GraphItemRelationship.ps1',
        '.\src\cmdlets\Set-GraphItem.ps1',
        '.\src\cmdlets\Set-GraphLocation.ps1',
        '.\src\cmdlets\Set-GraphPrompt.ps1',
        '.\src\cmdlets\Show-GraphHelp.ps1',
        '.\src\cmdlets\Update-GraphMetadata.ps1',
        '.\src\cmdlets\common\AutoGraphFormats.ps1xml',
        '.\src\cmdlets\common\ContextHelper.ps1',
        '.\src\cmdlets\common\FunctionParameterHelper.ps1',
        '.\src\cmdlets\common\GraphParameterCompleter.ps1',
        '.\src\cmdlets\common\GraphUriParameterCompleter.ps1',
        '.\src\cmdlets\common\LocationHelper.ps1',
        '.\src\cmdlets\common\MemberDisplayType.ps1',
        '.\src\cmdlets\common\MethodNameParameterCompleter.ps1',
        '.\src\cmdlets\common\MethodParameterParameterCompleter.ps1',
        '.\src\cmdlets\common\MethodUriParameterCompleter.ps1',
        '.\src\cmdlets\common\PermissionHelper.ps1',
        '.\src\cmdlets\common\QueryTranslationHelper.ps1',
        '.\src\cmdlets\common\RelationshipDisplayType.ps1',
        '.\src\cmdlets\common\RequestHelper.ps1',
        '.\src\cmdlets\common\SegmentHelper.ps1',
        '.\src\cmdlets\common\TypeHelper.ps1',
        '.\src\cmdlets\common\TypeParameterCompleter.ps1',
        '.\src\cmdlets\common\TypePropertyParameterCompleter.ps1',
        '.\src\cmdlets\common\TypeUriHelper.ps1',
        '.\src\cmdlets\common\TypeUriParameterCompleter.ps1',
        '.\src\common\GraphAccessDeniedException.ps1',
        '.\src\common\PreferenceHelper.ps1',
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
        '.\src\metadata\QualifiedSchema.ps1',
        '.\src\metadata\UriCache.ps1',
        '.\src\typesystem\MethodInfo.ps1',
        '.\src\typesystem\TypeMember.ps1',
        '.\src\typesystem\TypeSchema.ps1',
        '.\src\typesystem\TypeDefinition.ps1',
        '.\src\typesystem\TypeProvider.ps1',
        '.\src\typesystem\typesystem.ps1',
        '.\src\typesystem\ScalarTypeProvider.ps1',
        '.\src\typesystem\CompositeTypeProvider.ps1',
        '.\src\typesystem\TypeManager.ps1',
        '.\src\typesystem\GraphObjectBuilder.ps1'
    )

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('MSGraph', 'Graph', 'AADGraph', 'Azure', 'MicrosoftGraph', 'Microsoft-Graph', 'MS-Graph', 'AAD-Graph', 'GraphExplorer', 'REST', 'CRUD', 'GraphAPI', 'autograph', 'poshgraph', 'PSEdition_Core', 'PSEdition_Desktop', 'Windows', 'Linux', 'MacOS')

        # A URL to the license for this module.
        LicenseUri = 'http://www.apache.org/licenses/LICENSE-2.0'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/adamedx/autographps'

        # A URL to an icon representing this module.
        IconUri = 'https://raw.githubusercontent.com/adamedx/poshgraph/main/assets/PoshGraphIcon.png'

        # Adds pre-release to the patch version according to the conventions of https://semver.org/spec/v1.0.0.html
        # Requires PowerShellGet 1.6.0 or greater
        # Prerelease = '-preview'

        # ReleaseNotes of this module
        ReleaseNotes = @'
## AutoGraphPS 0.33.0 Release Notes

This release adds new commands dedicated to invoking methods (i.e. `OData` *Actions* and *Functions*). There is also new functionality for exploring the *methods* of types in addition to their *properties* and *relationships* (*navigation properties*). It also adds background metadata processing via ThreadJob rather than PowerShell jobs to optimize performance. And an included dependency that exposes commands to users of this module has renamed some fo those commands.

### New dependencies

* AutoGraphPS-SDK 0.23.0 -- this includes commands from the `AutoGraphPS-SDK` module that have been renamed
* ThreadJob 2.0.3 -- this is the introductory use of ThreadJob for this module

### Breaking changes

* The `GraphObject` parameter in `New-GraphObject` and `Set-GraphItem` has been renamed `TemplateObject`.
* The `PropertyMap` parameter in `New-GraphItem`, `New-GraphObject`, `Set-GraphItem`, and any other commands has been renamed to `PropertyTable`.
* Commands like Get-GraphItem, Set-GraphItem, etc., that allow specification of a type name and id as an alternative to a URI or object now expect a URI in the default parameter set, including in positionally bound parameters and pipeline parameters. It turns out that type name and id are ambiguous, as that combination cannot always be translated to a unique URI, particularly when an entity set for a given type is defined as using a base type for that type, or when there is no entity set that supports the type. This changes parameter bindings in a way that will break previous versions of several commands when positional binding is used or the pipeline is used.
* The `New-GraphItemRelationship` command now returns output, previously it returned none -- see the `New Features` section for details on the returned output.
* The following commands that originate from the `AutoGraphPS-SDK` dependency have been renamed -- if you use this module and try to invoke the commands by their earlier names, those invocations will fail:
  `Connect-Graph` is now `Connect-GraphApi`
  `Disconnect-Graph` is now `Disconnect-GraphApi`
  `Invoke-GraphRequest` is now `Invoke-GraphApiRequest`

### New features

* New command `Invoke-GraphMethod`: this command issues requests for actions and functions, i.e. *methods* of the Graph API
* New command `New-GraphMethodParameter`: this command creates objects for the parameters of a given method of an entity
* New command `Get-GraphItemRelationship`: this command returns the specified relationships from a given object to other objects
* The `New-GraphItemRelationship` now returns objects representing the relationship that was created -- previously this command had no output. The output format is the same as that of the new `Get-GraphItemRelationship` command and is accepted as input to an updated `Remove-GraphItemRelationship` command.
* `Get-GraphType` now returns *methods* of types in addition to *properties* and *relationships* (*navigation properties*)
* `Get-GraphType` has a new `MemberType` parameter to limit the transitive member list to just the specific types (`Property`, `Relationship`, and `Method`) of members.
* `Get-GraphType` now supports a `Uri` parameter to get type information about the type of any object in the graph given its Uri
* `Get-GraphType` now supports pipeline input to take an object emitted by `Get-GraphItem` or `Get-GraphResource` and return the type information for that object's type
* `ShowGraphHelp` has been updated to show help information based on a new `Uri` parameter
* `ShowGraphHelp` can also take in pipeline input to give help information for an object returned by other commands in this module
* Commands that return objects from the Graph now return the actual derived type of the object in heterogenous collections that are defined as returning a base type
* Metadata download and initial processing now uses a thread in the same process hosting AutoGraphPS, rather than a separate process. This offers a dramatic performance improvement in obtaining the API metadata that the commands rely upon. The new implementation uses `Start-ThreadJob` instead of `Start-Job` to process metadata asynchronously.

### Fixed defects

* In some cases, `New-GraphObject` would not correctly create arrays when an array was only of size 1, instead a scalar was emitted. This has been fixed to generate an array of size 1 in such cases. This issue caused Graph to reject requests with objects in this scenario due to an invlaid schema.
* `Set-GraphItem` now works in more cases when an object is piped in as the object to update but the object came from a POST request or is only accessible via a navigation property (e.g. /me/contacts).

None.
'@
    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
