function Get-AliasAZToken {


<#
.SYNOPSIS
    This script will get a access tokenfrom AAD for a permitted server

.DESCRIPTION
    This script will get a access tokenfrom AAD for a permitted server

.PARAMETER  None
This script only works on permitted servers and does not take any parameters

.EXAMPLE
	PS C:> Get-AliasAZToken

    this script can be used interactively with no params



.INPUTS
	None

.OUTPUTS
	will return a AAD token

.NOTES
	NA

.LINK
	https://iamshield.visualstudio.com/Modern%20Identity/_wiki/wikis/Modern-Identity.wiki/TBD

#>
    param (

    )


    begin {

        $token = $null
        $myFunctionName = $MyInvocation.MyCommand.ToString() + ":"

        Write-Verbose "$myFunctionName Begin."
        $AzureInstanceMetadataServiceUrl = 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01'
        $ResourceAppIDUri                = 'https://microsoft.onmicrosoft.com/05e0bb74-9854-4ab1-973b-2848dc014466'

    }#begin

    process {

        Try {

            Write-Verbose "$myFunctionName Process Azure token begin."

            $token =  Invoke-RestMethod -Uri "$AzureInstanceMetadataServiceUrl&resource=$ResourceAppIDUri" -Headers @{Metadata=$true}

            if ($token) {

                Write-Verbose "$myFunctionName Azure token acquired sucessfully."

            }
            else {

                throw "TokenNotAcquired"

            }

            Write-Verbose "$myFunctionName Process Azure token end."

        }
        catch {

            $message = "$myFunctionName : Azure token NOT acquired sucessfully. Error message is: " + $_.Exception.message
            Write-Error -entryType Error -eventID 35299 -message $message -source $source

            throw "TokenNotAcquired"

        }

        return $token
    }#processs

    end {

        Write-Verbose "$myFunctionName End."

    }#end


}
