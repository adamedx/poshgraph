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

set-strictmode -version 2

# This test assumes the module has been imported

. (join-path $psscriptroot ../../test/common/CompareCustomObject.ps1)

function GetAllObjects {
    'Complex', 'Enumeration', 'Primitive', 'Entity' | foreach {
        $typeClass = $_
        Get-GraphType -list -typeclass $typeClass | foreach {
            $objectJson = New-GraphObject -TypeClass $typeClass $_ -json -setdefaultvalues -recurse
            if ( ! $objectJson -and ( $typeClass -ne 'Primitive' -and $_ -ne 'Binary' ) ) {
                throw "Unable to create a new object of type '$_' of typeclass '$typeClass'"
            }
        }
    }
}

Describe 'The New-GraphObject command' {
    Context 'When invoked using v1 metadata with v1 metadata' {
        BeforeAll {
            $progresspreference = 'silentlycontinue'
            Update-GraphMetadata -Path "$psscriptroot/../../test/assets/v1metadata-ns-alias-2020-01-22.xml" -force -wait -warningaction silentlycontinue
        }

        It 'Should emit an array object for a given property even when the array specified by the value parameter has only one element when the type of the property is an array' {
            $emailAddress = New-GraphObject -TypeClass Complex emailAddress -Property name, address -value Home, sorry@thisman.org
            $contactdata = New-GraphObject microsoft.graph.contact -PropertyList @{givenName='SorryTo ThisMan';emailAddresses = @($emailAddress)}

            $expectedJSON = '{"givenName":"SorryTo ThisMan","emailAddresses":[{"name":"Home","address":"sorry@thisman.org"}]}'

            $contactData.emailAddresses.GetType().isarray | Should Be $true
            $contactData | convertTo-json -compress | Should Be $expectedJSON
        }

        It 'Should emit an array object for a given property even when the array specified by the PropertyList parameter has only one element when the type of the property is an array' {
            $emailAddress = New-GraphObject -TypeClass Complex emailAddress -Property name, address -value Home, sorry@thisman.org
            $contactdata = New-GraphObject microsoft.graph.contact -PropertyList @{givenName='SorryTo ThisMan';emailAddresses = @($emailAddress)}

            $expectedJSON = '{"givenName":"SorryTo ThisMan","emailAddresses":[{"name":"Home","address":"sorry@thisman.org"}]}'

            $contactData.emailAddresses.GetType().isarray | Should Be $true
            $contactData | convertTo-json -compress | Should Be $expectedJSON
        }

        It 'Should be able to return all the objects in the v1 metadata' {
            { GetAllObjects } | Should Not Throw
        }
    }

    Context 'When invoked using beta metadata ' {
        BeforeAll {
            $progresspreference = 'silentlycontinue'
            Update-GraphMetadata -Path "$psscriptroot/../../test/assets/betametadata-ns-alias-2020-01-23.xml" -force -wait -warningaction silentlycontinue
        }

        It 'Should be able to return all objects in the beta metadata' {
            { GetAllObjects } | Should Not Throw
        }
    }
}

