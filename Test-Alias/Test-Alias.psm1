function Test-Alias {
Param ($Alias)

    $result = $false


    $Global:token = Get-AliasAZToken

    $result = Get-AliasIsAvailable -Alias $Alias

    if ($false -eq $result) {

    Write-Host "The Alias '$Alias' is NOT Available" -ForegroundColor Red 

    $details = get-AliasDetails -Alias $Alias
    Write-Host ("AR details:") 
     $details

    $Adobject = Get-ADObject -Filter {mailNickname -eq $Alias} -Server corp:3268
    if ($null -eq $Adobject) {

        Write-Host "No AD Object found with alias $Alias in the corp forest" -ForegroundColor Red

    }

    else {

        Write-Host ("AD Object: `n" + $Adobject.DistinguishedName) -ForegroundColor Green

    }

    }

    else {

    Write-Host "The Alias '$Alias' IS Available" -ForegroundColor Green }

}


#swagger url https://api.coreidentity.microsoft.com/swagger/index.html

