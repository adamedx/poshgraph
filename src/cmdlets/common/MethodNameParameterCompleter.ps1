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

ScriptClass MethodNameParameterCompleter {
    function CompleteCommandParameter {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
        $graphName = $fakeBoundParameters['GraphName']
        $typeName = $fakeBoundParameters['TypeName']
        $fullyQualified = if ( $fakeBoundParameters['FullyQualifiedTypeName'] ) {
            $fakeBoundParameters['FullyQualifiedTypeName'].IsPresent
        } else {
            $typeName -ne $null -and $typeName.Contains('.')
        }

        if ( ! $typeName ) {
            return $null
        }

        $targetContext = $::.ContextHelper |=> GetContextByNameOrDefault $graphName

        if ( $targetContext ) {
            $typeManager = $::.TypeManager |=> Get $targetContext
            $isFullyQualified = $fullyQualified -or ( $typeName.Contains('.') )

            $methods = $::.TypeMemberFinder |=> FindMembersByTypeName $targetContext $typeName Method $null $null $null

            if ( $methods ) {
                $methods.Name | where { $_.StartsWith($wordToComplete, [System.StringComparison]::InvariantCultureIgnoreCase) }
            }
        }
    }
}
