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

. (import-script GraphCache)

ScriptClass GraphManager {

    static {
        $cache = $null

        const TimeStateKey TimeData
        const UriCacheStateKey UriCache
        const TypeStateKey TypeManager
        const MetadataSourceStateKey MetadataSource

        function __initialize {
            $this.cache = new-so GraphCache
            # Start an asynchronous load of the metadata unless this is disabled
            # This is only meant for user interactive sessions and should be
            # disabled if this module is used in background jobs
            if ( ! (get-variable -scope script -name '__poshgraph_no_auto_metadata' -erroraction ignore) ) {
                write-verbose "Asynchronously updating Graph metadata"
                UpdateGraph ($::.GraphContext |=> GetCurrent)
            } else {
                write-verbose "Found __poshgraph_no_auto_metadata variable, skipping Graph metadata update"
            }
        }

        function UpdateGraph($context, $metadata = $null, $wait = $false, $force = $false, $metadataSourceOverridePath) {
            $graphEndpoint = $context |=> GetEndpoint

            # Trigger a graph update -- we purposefully ignore the result as it may not be a graph
            # but instead an incomplete retrieval. The goal here is simply to trigger the update, not
            # to get the results.
            __GetGraph $graphEndpoint $context.version $metadata $wait $force $true | out-null

            # Clear any existing cache as it is no longer valid given that the graph is being updated.
            $uriCache = $context |=> GetState $this.UriCacheStateKey
            if ( $uriCache ) {
                $uriCache.Clear() # TODO: Need to change this to handle async retrieval of new graph
            }

            # Also remove any state for the TypeManager as the updated graph will invalidate it as well.
            $typeManager = $context |=> GetState $this.TypeStateKey

            if ( $typeManager ) {
                $context |=> RemoveState $this.TypeStateKey
            }

            # Set the time of creation if this context is new and otherwise
            # change the last updated time to reflect the time of this update
            $updateTime = [DateTimeOffset]::Now
            $timeData = $context |=> GetState $this.TimeStateKey

            if ( $timeData ) {
                $timeData.UpdatedTime = $updateTime
            } else {
                $timeData = [PSCustomObject] @{
                    CreatedTime = $updateTime
                    UpdatedTime = $updateTime
                }
            }

            $context |=> SetState $this.TimeStateKey $timeData

            # Finally set the location from which the graph's metadata is retrieved
            # to reflect what is being used in this update.
            $updateSource = if ( $metadataSourceOverridePath ) {
                $scheme = ( [Uri] $metadataSourceOverridePath ).scheme
                if ( ! $scheme -or $scheme -eq 'file' ) {
                    $metadataFileItem = get-item $metadataSourceOverridePath -erroraction ignore
                    if ( $metadataFileItem ) {
                        $metadataFileItem.FullName
                    }
                } else {
                    $metadataSourceOverridePath
                }
            } else {
                $graphEndpoint.tostring().trimend('/'), $context.version, '$metadata' -join '/'
            }

            $context |=> SetState $this.MetadataSourceStateKey $updateSource
        }

        function GetMetadataStatus($context) {
            # See comments in __GetGraph about the still unknown need for this
            if ( ! $this.cache ) {
                __initialize
            }

            $this.cache |=> GetMetadataStatus $context.connection.GraphEndpoint.Graph $context.version
        }

        function GetGraph($context, $metadata = $null, $force = $false) {
             __GetGraph ($context |=> GetEndpoint) $context.version $metadata $true $force
        }

        function __GetGraph($endpoint, $apiVersion, $metadata, $wait = $false, $force = $false, $forceupdate = $false) {
            # This really should not be necessary since __initialize is called at the script level, but there
            # seems to be an issue when executing in automated CI where class members are not initialized,
            # possibly due to some inability to call __initialize at some point -- we call it here if we detect
            # uninitalized state and this seems to "fix" the CI.
            if ( ! $this.cache ) {
                __initialize
            }

            if ( $Force ) {
                $this.cache |=> CancelPendingGraph $endpoint $apiVersion
            }

            if ( $wait -and ! $forceupdate ) {
                $this.cache |=> GetGraph $endpoint $apiVersion $metadata
            } else {

                $asyncResult = $this.cache |=> GetGraphAsync $endpoint $apiVersion $metadata

                if ( $wait ) {
                    $this.cache |=> WaitForGraphAsync $asyncResult
                } else {
                    $asyncResult
                }
            }
        }
    }
}

$::.GraphManager |=> __initialize
