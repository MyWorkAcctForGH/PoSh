﻿function Get-AliasDetails {

    [CmdletBinding()]
    Param (

        [Parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true,
        Position=0)]
        [string]$Alias

    )


$result = Invoke-RestMethod -Uri "https://api.coreidentity.microsoft.com/api/v1.0/Alias/details/$Alias" -Headers @{Authorization = "Bearer $($token.Access_Token)"}

return $result

}