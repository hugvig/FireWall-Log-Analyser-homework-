<#read the PIHole file and get every IP address and resolve them#>
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

    $logs = $lines | ForEach-Object{
        ConvertFrom-Log -line $_
    }

    return $logs
    
}