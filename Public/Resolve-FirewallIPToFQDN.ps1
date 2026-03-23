<#read the PIHole file and get every IP address and resolve them#>
function Resolve-FirewallIPToFQDN()
{
    <#The pattern used to find the reply lines and get the FQDN and its IP address (IPv4 or IPv6)#>
    $pattern = '(?:reply\s(.*)\sis\s((?:(?:[0-9a-f]){1,4}:){3}:(?:(?:[0-9a-f]){1,4}:)(?:[0-9a-f]){1,4})$)|
                (?:reply\s(.*)\sis\s(((?:(?:[0-9a-f]){1,4}:){7}(?:[0-9a-f]){1,4}))$)|
                (?:reply\s(.*)\sis\s((?:\d{1,3}\.){3}\d{1,3})$)'

                
    
}