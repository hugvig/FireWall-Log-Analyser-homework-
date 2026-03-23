<#
.SYNOPSIS
Filter the properties of the logs

.DESCRIPTION
This function filters the properties of the logs related to the path variable 
using the fields entered by the user.

.PARAMETER path
The parameter path is the relative path to the firewall logs file

.PARAMETER fields
Choose which fields of the firewall log you want to analyse 
(scr_ip, dst_ip, nat-rule_name, dst_port or/and user_name) if no field is inputed then
all the fields will be selected.

.NOTES
Author: Loic Ollervides
#>
function Select-FirewallLogs
{
    Param
    (
        [Parameter (Mandatory)]
        [string] $path,

        [string[]] $fields
    )

    try
    {
        $logs = Get-FirewallLogs -path $path
    }
    catch [System.IO.FileNotFoundException]
    {
        throw "Cannot find path '$path' because it does not exist."
    }

    <#initialising our variables#>
    [string[]] $possibleFields = @("src_ip", "dst_ip", "fw_rule_name", "dst_port", "user_name")
    $filteredLogs = $null
    
    <#Check if the array fields is not empty#>
    if ($fields.Count -ne 0)
    {
        ForEach($field in $fields)
        {
            <#Check if the field entered by the user is not it the possible fields options#>
            if($field -notin $possibleFields)
            {
                <#Stop the execution if the fields is not correct#>
                throw "The parameter $field is not recognized." 
            }
        }
        
        <#We filter the logs based on the user inputed fields. We do that by counting how many fields dont match the ones the user wants
        and check if the lenght of this collection is 0 meaning that they match what the user wants#>
        $filteredLogs = $logs | Where-Object { 
            $log = $_
            ($fields | Where-Object { !$log.$_ }).Count -eq 0
        } | Select-Object -Property $fields
    }
    else 
    {
        <#We filter the logs selecting all the possible fileds by default. We do that by counting how many fields dont match the ones that are in the possibleFields variable
        and check if the lenght of this collection is 0 meaning that they match what is in the possibleFields variable#>
    $filteredLogs = $logs | Where-Object { 
            $log = $_
            ($possibleFields | Where-Object { !$log.$_ }).Count -eq 0
        } | Select-Object -Property $possibleFields
    }

    return $filteredLogs

}