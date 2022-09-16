function Get-TicketType{
    param(
        [parameter()][string]$Department='*',
        [parameter()][string]$TicketType='*'
    )

    $depts = @( get-ticketdepartment `
        | where-object { $_.title -like "$department" } `
        | select-object -expand id
        )
    $depts += @('0')

    $endpoint  = 'Tickets/TicketType'

    # HTTP parameters
    $paramies  = @{
        method = 'GET'
        uri    = @($($script:config.server, $endpoint -join '/'), $(new-signature)) -join '&'
    }

    # GET /Tickets/TicketPriority
    invoke-restmethod @paramies `
        | convertto-kayakoobject `
        | where-object { $_.title -like "$tickettype" -and $_.departmentid -in $depts }

}