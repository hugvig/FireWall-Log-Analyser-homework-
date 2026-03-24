<#
.SYNOPSIS
Creates a Log object from a PiHole file

.DESCRIPTION
Recieves a line from the Firewall log file and uses a regex expression to identfy the name and value of the field,
 then it creates a hash table with the IP as keys a list of domains as its value

.PARAMETER line
The Firewall log line recieved from the caller function

.NOTES
Author: Loic Ollervides
#>
function Resolve-IPToDomain
{
    Param
    (
        [Parameter (Mandatory)]
        [String[]] $lines
    )

    <#The regular expression used for filtering the IP resolution from the PiHole file#>
    $pattern = 'reply\s(\S+)\sis\s(\S+)$'

    <#We create an empty hastable for the properties of our object#>
    $IPToDomain = @{}

    foreach($line in $lines)
    {
        <#We store all the field that match with our expression (three groups of match, Group 0 is the whole expression,
         Group 1 is the match with our first set of parenthesis and Group 3 is the 
         match with our second set of parenthesis)#>
        $fits = [regex]::Matches($line, $pattern)

        <#For each Match in the line we take the name of the field (Group 1) and the value of the field (Group 2)
         and set it as a key/value pair in our hash table#>
        foreach($match in $fits)
        {
            $key = $match.Groups[2].Value
            $value = $match.Groups[1].Value

            <#check if the key is not <CNAME>#>
            if ($key -ne "<CNAME>")
            {
                <#check if the key does not exist#>
                if(!($key -in $IPToDomain.Keys))
                {
                    <#Create a .Net list (resizable array) of strings#>
                    $IPToDomain[$key] = New-Object System.Collections.Generic.List[string]
                    $IPToDomain[$key].Add($value)
                }
                else
                {
                    <#check if the new value is not already in the values#>
                    if(!($value -in $IPToDomain[$key]))
                    {
                        $IPToDomain[$key].Add($value)
                    }   
                }

            }

        }

    }

    <#We return our hash table#>
    return $IPToDomain

}