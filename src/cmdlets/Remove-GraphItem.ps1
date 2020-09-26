# Copyright 2020, Adam Edwards
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

. (import-script ../typesystem/TypeManager)
. (import-script common/TypeUriHelper)
. (import-script common/QueryTranslationHelper)
. (import-script common/GraphParameterCompleter)
. (import-script common/TypeParameterCompleter)
. (import-script common/TypePropertyParameterCompleter)
. (import-script common/TypeUriParameterCompleter)
. (import-script Get-GraphResourceItem)

function Remove-GraphResourceItem {
    [cmdletbinding(positionalbinding=$false, defaultparametersetname='byuri')]
    param(
        [parameter(position=0, parametersetname='byuri', mandatory=$true)]
        [parameter(parametersetname='byuripipeline', valuefrompipelinebypropertyname=$true, mandatory=$true)]
        [Alias('GraphUri')]
        [Uri] $Uri,

        [parameter(parametersetname='bytypeandid', mandatory=$true)]
        [parameter(parametersetname='bytypeandfilter', mandatory=$true)]
        $TypeName,

        [parameter(position=1, parametersetname='bytypeandid', valuefrompipeline=$true, mandatory=$true)]
        $Id,

        [parameter(parametersetname='byobject', valuefrompipeline=$true, mandatory=$true)]
        [parameter(parametersetname='byobjectandfilter', valuefrompipeline=$true, mandatory=$true)]
        [PSCustomObject] $GraphItem,

        [parameter(parametersetname='byobject')]
        [parameter(parametersetname='byobjectandfilter')]
        [parameter(parametersetname='bytypeandid')]
        [parameter(parametersetname='bytypeandfilter')]
        [parameter(parametersetname='byuripipeline', valuefrompipelinebypropertyname=$true, mandatory=$true)]
        $GraphName,

        [parameter(parametersetname='bytypeandfilter', mandatory=$true)]
        [parameter(parametersetname='byuri')]
        [parameter(parametersetname='byobjectandfilter', mandatory=$true)]
        $Filter,

        [switch] $FullyQualifiedTypeName
    )

    begin {
        Enable-ScriptClassVerbosePreference

        $filterParameter = @{}
        $filterValue = $::.QueryTranslationHelper |=> ToFilterParameter $null $Filter
        if ( $filterValue ) {
            $filterParameter['Filter'] = $filterValue
        }
    }

    process {
        $targetId = if ( $Id ) {
            $Id
        }

        $requestInfo = $::.TypeUriHelper |=> GetTypeAwareRequestInfo $GraphName $TypeName $FullyQualifiedTypeName.IsPresent $Uri $targetId $GraphItem

        $objects = Get-GraphResource $requestInfo.Uri @filterParameter -erroraction stop

        foreach ( $targetObject in $objects ) {
            if ( ! ( $targetObject | gm id -erroraction ignore ) ) {
                break
            }

            $targetUri = $::.TypeUriHelper |=> GetUriFromDecoratedObject $requestInfo.Context $targetObject
            Invoke-GraphApiRequest $targetUri -Method DELETE -erroraction stop -connection $requestInfo.Context.Connection | out-null
        }
    }

    end {}
}

$::.ParameterCompleter |=> RegisterParameterCompleter Remove-GraphResourceItem TypeName (new-so TypeUriParameterCompleter TypeName)
$::.ParameterCompleter |=> RegisterParameterCompleter Remove-GraphResourceItem GraphName (new-so GraphParameterCompleter)


