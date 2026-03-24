@{

    <#Script module file associated with this manifest#>
    RootModule = 'FirewallLogAnalyser.psm1'

    <#Mimnimum PowerShell version#>
    PowerShellVersion = '5.1'

    <#The version of the module#>
    ModuleVersion = '1.0.0'

    <#ID used to uniquely identify this module#>
    GUID = 'e21bcdec-c3d1-4985-87fe-255f17694bd8'

    <#Author of this module#>
    Author = 'Loic Ollervides and Justin Dionne'

    <#Company#>
    CompanyName = 'Polytechnique Montreal'

    <#Description of the functionality provided by this module#>
    Description = 'Module for analyzing firewall logs, filtering fields, and resolving IP addresses to FQDN.'

    <#Functions to export#>
    FunctionsToExport = @(
        'Get-FirewallLogs',
        'Select-FirewallLogs',
        'Resolve-FirewallIPToFQDN'
    )

}