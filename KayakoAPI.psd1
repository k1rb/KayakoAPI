@{

    RootModule          = 'KayakoAPI'
    ModuleVersion       = '0.4'
    PowerShellVersion   = '5.1'
    GUID                = 'd37315d9-1337-40a9-a961-30d2372beb88'
    Author              = 'Bradd Roberson'
    CompanyName         = ''
    Description         = 'Powershell 5.1+ Module for Kayako Fusion (Classic)'
    Copyright           = 'GPL'
    FunctionsToExport   = @(
        'Get-Ticket','Get-TicketDepartment','Get-TicketNote','Get-TicketPost',
        'Get-TicketAttachment','Export-TicketAttachment',
        'Get-TicketPriority','Get-TicketStaff','Get-TicketStatus','Get-TicketType',
        'Search-Ticket',
        'Resolve-TicketStatusID','Resolve-TicketDepartmentID','Resolve-TicketTypeID','Resolve-TicketPriorityID',
        'New-Ticket','New-TicketNote'
        'Remove-Ticket','Remove-TicketNote',
        'Set-Ticket'
    )
    CmdletsToExport     = @()
    VariablesToExport   = '*'
    AliasesToExport     = @()
    PrivateData         = @{ PSData = @{} }

}
