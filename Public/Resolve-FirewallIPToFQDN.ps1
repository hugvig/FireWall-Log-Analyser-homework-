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
        [string] $pathIP,

        [Parameter (Mandatory)]
        [string] $pathPH
    )

    try 
    {
        $linesPH = Get-Content $pathPH
    }
    catch 
    {
        throw "Cannot find path '$pathPH' because it does not exist."
    }

    $MappedIPs = Resolve-IPToDomain -lines $linesPH 

    $dst_ip = (Select-FirewallLogs -path $pathIP -fields dst_ip).dst_ip


    foreach($ip in $dst_ip)
    {
        if ($ip -in $MappedIPs.keys)
        {
            Write-host "$ip -> $($MappedIPs[$ip]) `n"
        }
    }
    
}