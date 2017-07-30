# graph demo


class GraphContext {
    $AuthContext
    $Endpoint
    $GraphType

    static [string] GetGraphEndpoint($graphType, $alternateEndpoint) {
        [GraphContext]::ValidateGraphType($graphType)
        $result = if ( $alternateEndpoint -ne $null ) {
            $alternateEndpoint
        } elseif ( $graphType -eq 'msgraph' ) {
            [GraphContext]::MSGraphEndpoint()
        } else {
            [GraphContext]::AADGraphEndpoint()
        }
        return $result
    }

    static [string] AADGraphEndpoint() {
        return "https://graph.windows.net"
    }

    static [string] MSGraphEndpoint() {
        return "https://graph.microsoft.com/v1.0"
    }

    static [string] AADGraphAppId() {
        return "42c41bc4-75da-4142-91d7-baf15cc24fb9"
    }

    static [string] MSGraphAppId() {
        return "01e45b18-f1e5-4e66-b2db-09ce7909b99d"
    }

    static [string] GetTenantEndpointComponent($graphType, $endpointRoot, $tenantName) {
        $result = if ($graphType -eq 'adgraph') {
            if ( $tenantName -eq $null) {
                throw "No tenant was specified for the ad graph endpoint"
            }
            $endpointRoot + "/$tenantName"
        } else {
            $endpointRoot
        }

        return $result
    }

    static [string] GetUriQueryComponent($graphType, $query = $null) {
        $result = ""
        $querySeparator = '?'
        if ($graphType -eq 'adgraph') {
            $result = "?api-version=1.6"
            $querySeparator = '&'
        }

        if ($query -ne $null) {
            $result += ($querySeparator + $query)
        }

        return $result
    }

    static [string] RestAPIResourceUri($endpoint, $resource, $query) {
        $strictUri = "$endpoint/$resource"

        $result = if ($query -eq $null) {
            $strictUri
        } else {
            "$($strictUri)$($query)"
        }

        return $result
    }

    static [string] RestAPIResourceUriForGraph($graphType, $endpointRoot, $tenantName, $resource, $query) {
        $graphEndpoint = [GraphContext]::GetTenantEndpointComponent($graphType, $endpointRoot, $tenantName)
        $queryComponent = [GraphContext]::GetUriQueryComponent($graphType, $query)
        return [GraphContext]::RestAPIResourceUri($graphEndpoint, $resource, $queryComponent)
    }

    InitializeGraphType($graphType) {
        [GraphContext]::ValidateGraphType($graphType)
        $this.GraphType = $graphType
    }

    GraphContext($graphType = 'msgraph', $authContext) {
        $this.Endpoint = $null
        $this.AuthContext = $authContext
        $this.InitializeGraphType($graphType)
    }

    GraphContext($graphType = 'msgraph', $authType = 'msa',  $tenantName = $null, $alternateAppId = $null, $alternateEndpoint = $null, $alternateAuthority = $null) {
        $this.InitializeGraphType($graphType)
        $this.Endpoint = [GraphContext]::GetGraphEndpoint($graphType, $alternateEndpoint)
        $this.InitializeAuth($graphType, $authType, $tenantName, $alternateAppId, $alternateEndpoint, $alternateAuthority)
    }

    static ValidateGraphType($graphType) {
        $validGraphs = @('msgraph', 'adgraph')
        if (-not $graphType -in $validGraphs) {
            throw "Invalid graph type '$graphType' was specified -- must be one of '$($validGraphs -join ',')'"
        }
    }
    InitializeAuth($graphType = 'msgraph', $authType = 'msa', $tenantName = $null, $altAppId = $null, $altEndpoint, $altAuthority = $null) {
        $resourceAppIdUri = if ($authType -eq 'aad') {
            [GraphContext]::GetGraphEndpoint($graphType, $altEndpoint)
        } else {
            $null
        }

        $appId = $altAppId

        if ($appId -eq $null) {
            $appId = if ($graphType -eq 'adgraph') {
                [GraphContext]::AADGraphAppId()
            } else {
                [GraphContext]::MSGraphAppId()
            }
        }

        $this.AuthContext = [GraphAuthenticationContext]::new($authType, $appId, $tenantName, $resourceAppIdUri, $altAuthority)
    }

    [object] InvokeRestAPIMethod($uri, $header, $method="GET") {
        write-host "Uri: $uri"
        $result = try {
            Invoke-RestMethod -Uri $uri -Headers $header -method $method
        } catch {
            write-error $_.Exception
            $_.Exception.Response | out-host
            $null
        }
        return $result
    }

    [object] GetRestAPIHeader($token) {
        # Building Rest Api header with authorization token
        return @{
            'Content-Type'='application\json'
            'Authorization'=$token.CreateAuthorizationHeader()
        }
    }

    [object] CallRestAPIMethodForResource($uri, $restAPIHeader) {
        return $this.InvokeRestAPIMethod($uri, $restAPIHeader, "GET")
    }

    [object] GetRestAPIResponseForResource($resourceUri, $token, $query = $null) {
        $restAPIHeader = $this.GetRestAPIHeader($token)
        $uri = [GraphContext]::RestAPIResourceUriForGraph($this.GraphType, $this.Endpoint, $this.AuthContext.TenantName, $resourceUri, $query)
       return $this.CallRestAPIMethodForResource($uri, $restAPIHeader)
    }

    [object] GetGraphAPIResponse($relativeResourceUri, $query = $null) {
        return $this.GetRestAPIResponseForResource($relativeResourceUri, $this.AuthContext.Token, $query)
    }
}

class GraphAuthenticationContext {
    $AppId
    $Authority
    $AuthType
    $ResourceAppIdUri
    $TenantName
    $Token

    GraphAuthenticationContext($authType = 'msa', $appId, $tenantName = $null, $resourceAppIdUri = $null, $altAuthority = $null) {

        if ($appId -eq $null) {
            throw "A mandatory appId was not specified"
        }

        $validAuthTypes = @('msa', 'aad')
        if (-not $authType -in $validAuthTypes) {
            throw "Invalid auth type '$authType' was specified -- must be one of '$(validAuthTypes -join ',')'"
        }

        if ($authType -eq 'msa' -and $tenantName -ne $null) {
            throw "Tenant '$tenantName' was specified when authentication type 'msa' requires tenant to be unspecified."
        }

        $authorityValue = $altAuthority

        if ($authType -eq 'aad') {
            if ($tenantName -eq $null) {
                throw "A tenant name must be specified for authentication type 'aad'"
            }

            if ($resourceAppIdUri -eq $null) {
                throw "A resource AppId URI must be specified for authentcation type 'aad'"
            }

            if ($authorityValue -eq $null) {
                $authorityValue = "https://login.windows.net/$tenantName"
            }

            $adal = "${env:ProgramFiles(x86)}\Microsoft SDKs\Azure\PowerShell\ServiceManagement\Azure\Services\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"
            [System.Reflection.Assembly]::LoadFrom($adal) | Out-Null
        } else {
            if ($altAuthority -ne $null) {
                throw "An authority must *not* be specified for authentication type 'msa'"
            }
            $scriptDirectory = split-path -parent $pscommandpath
            $graphAuthLibraryPath = join-path -path $scriptDirectory -childpath "Microsoft.Identity.Client.1.1.0-preview\lib\net45\Microsoft.Identity.Client.dll"
            [System.Reflection.Assembly]::LoadFrom($graphAuthLibraryPath) | Out-Null
        }

        $this.AppId = $appId
        $this.Authority = $authorityValue
        $this.AuthType = $authType
        $this.ResourceAppIdUri = $resourceAppIdUri
        $this.tenantName = $tenantName
        $this.Token = $null
    }

    [object] AcquireToken() {
        if ($this.Token -eq $null) {
            if ($this.AuthType -eq 'aad') {
                $adalAuthContext = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext" -ArgumentList $this.Authority
                $redirectUri = "http://localhost"
                $this.Token = $adalAuthContext.AcquireToken($this.ResourceAppIdURI, $this.AppId, $redirectUri, "Auto")
            } else {
                $msaAuthContext = New-Object "Microsoft.Identity.Client.PublicClientApplication" -ArgumentList $this.AppId
                $scopes = new-object System.Collections.Generic.List[string]
                $scopes.Add("User.Read")
                $this.Token = $msaAuthContext.AcquireTokenAsync($scopes).Result
            }
        }
        return $this.Token
    }
}

class GraphConnection {
    $Context
    $Connected = $false
    GraphConnection($graphType, $authContext) {
        $this.Context = [GraphContext]::new($graphType, $authContext)
        InitializeGraphType $graphType
        $this.AuthContext = $authContext
    }
    GraphConnection($graphType = 'msgraph', $authType = 'msa', $tenantName = $null, $altAppId = $null, $altEndpoint = $null, $altAuthority = $null) {
        $this.Context = New-GraphContext $graphType $authType $tenantName $altAppId $altEndpoint $altAuthority
    }

    Connect() {
        if ( ! $this.Connected ) {
            $this.Context.AuthContext.AcquireToken() | out-null
            $this.Connected = $true
        }
    }
}

function Get-MSAAuthContext {
    [CmdletBinding()]
    param($alternateAppId = $null)

    $appId = $alternateAppId

    if ($appId -eq $null) {
        $appId = [GraphPublicEndpoint]::MSGraphAppId()
    }

    $authContext = [GraphAuthenticationContext]::new('msa', $appId, $null, $null, $null)
    $authContext
}

function Get-AADAuthContext {
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$true)] [string] $tenantName,
                                              $alternateAppId = $null,
                                              $altResourceAppIdUri = $null,
                                              $alternateAuthority = $null
    )

    $resourceAppIdUri = $altResourceAppIdUri

    if ($resourceAppIdUri -eq $null) {
        $resourceAppIdUri = [GraphPublicEndpoint]::AADGraphEndpoint()
    }

    $appId = $alternateAppId

    if ($appId -eq $null) {
        $appId = [GraphPublicEndpoint]::AADGraphAppId()
    }

    $authContext = [GraphAuthenticationContext]::new('aad', $appId,  $tenantName, $resourceAppIdUri, $alternateAuthority)

    $authContext
}

function New-GraphContext($graphType = 'msgraph', $authtype = 'msa', $tenantName = $null, $alternateAppId = $null, $alternateEndpoint = $null, $alternateAuthority = $null) {
    [GraphContext]::new($graphType, $authtype, $tenantName, $alternateAppId, $alternateEndpoint, $alternateAuthority)
}

function New-GraphConnection($graphType = 'msgraph', $authtype = 'msa', $tenantName = $null, $alternateAppId = $null, $alternateEndpoint = $null, $alternateAuthority = $null) {
    [GraphConnection]::new($graphType, $authtype, $tenantName, $alternateAppId, $alternateEndpoint, $alternateAuthority)
}

function ConnectToGraph($defaultConnection = $null) {
    $connection = if ($defaultConnection -eq $null) {
        New-GraphConection
    } else {
        $defaultConnection
    }

    $connection.Connect()
    $connection
}

function Get-GraphItem($itemRelativeUri, $connection = $null) {
    (ConnectToGraph $connection).Context.GetGraphAPIResponse($itemRelativeUri, $null)
}

function Get-GraphItemRelativeQueryUri($itemRelativeUri, $connection = $null, $links = $false, $customQuery = $null) {
}


function Set-GraphData($itemRelativeUri, $connection = $null) {
}

function Get-GraphQueryData($itemRelativeUri, $oDataQuery, $connection = $null) {
}




