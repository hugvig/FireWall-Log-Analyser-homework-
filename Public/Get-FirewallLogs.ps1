<#
.SYNOPSIS
This function displays the firewall logs with all their fields

.DESCRIPTION
This function reads line per line a firewall log file and seperate each field of each log (line) and displays

.PARAMETER path
the parameter path is the relative path to the firewall logs file

.OUTPUTS
The logs and their relative filed separated

.NOTES
Author: Loic Ollervides
#>
function Get-FirewallLogs
{
    Param 
    (
        [Parameter(mandatory)]
        [string] $path
    )

    try
    {
        $lines = Get-Content $path
    }
    catch [System.IO.FileNotFoundException]
    {
        throw "Cannot find path '$path' because it does not exist."
    }

    <#We read each log line and send it to our function that will create the LogObject#>
    $logs =  $lines | ForEach-Object {
    ConvertFrom-FWLogLine -Line $_
    }

    return $logs
}