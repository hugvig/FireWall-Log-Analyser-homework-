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
function Convert-LogToPH
{
    Param
    (
        [Parameter (Mandatory)]
        [String] $line
    )

    <#The regular expression used for filtering the IP resolution from the PiHole file#>
    $pattern = 'reply\s(\S+)\sis\s(\S+)$'

    <#We create an empty hastable for the properties of our object#>
    $properties = @{}

    <#We store all the field that match with our expression (three groups of match, Group 0 is the whole expression,
     Group 1 is the match with our first set of parenthesis and Group 3 is the 
     match with our second set of parenthesis)#>
    $fits = [regex]::Matches($line, $pattern)

    <#For each Match in the line we take the name of the field (Group 1) and the value of the field (Group 2)
     and set it as a key/value pair in our hash table#>
    foreach($match in $fits)
    {
        $key = $match.Groups[1].Value
        $value = $match.Groups[2].Value.Trim('"')

        if ($value -ne "<CNAME>")
        {
            $properties[$key] = $value
        }
        
    }

    <#We create an object using our hash table#>
    return [PSCustomObject]$properties

}