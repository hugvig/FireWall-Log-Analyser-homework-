<#read the PIHole file and get every IP address and resolve them#>
<#
.SYNOPSIS
This function maps the Domain name to its IP adresse(s)

.DESCRIPTION
This function maps the Domain found in the file from the specified path to its IP addresses

.PARAMETER path
The relative path to the pihole file

.NOTES
Author: Loic Ollervides
#>
function Resolve-FirewallIPToFQDN()
{
    Param
    (
        [Parameter (Mandatory)]
        [string] $path
    )

    try 
    {
        $lines = Get-Content $path
    }
    catch 
    {
        throw "Cannot find path '$path' because it does not exist."
    }

    

    return Convert-LogToPH -lines $lines 
    
}