<#
.SYNOPSIS
Creates a Log object

.DESCRIPTION
Recieves a line from the Firewall log file and uses a regex expression to identfy the name and value of the field,
 then it creates and object using those properties

.PARAMETER line
The Firewall log line recieved from the caller function

.NOTES
Author: Loic Ollervides
#>
function ConvertFrom-Log
{
    Param
    (
        [Parameter (Mandatory)]
        [String] $line
    )

    <#The function that called this function#>
    $caller = (Get-PSCallStack)[1].Command

    <#Check which function is the caller and choose the appropriated pattern select the logs#>
    switch ($caller) {
        "Get-FirewallLogs"         { return Convert-LogToFW -line $line }
        "Resolve-FirewallIPToFQDN" { return Convert-LogToPH -line $line}
        Default { }
    }
}