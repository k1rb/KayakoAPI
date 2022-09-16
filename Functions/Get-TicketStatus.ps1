function Get-TicketStatus{
    param(
        [parameter()][string]$Department='*'
    )

    # Enumerate department id's
    $depts = @( get-ticketdepartment `
        | where-object { $_.title -like "$department" } `
        | select-object -expand id
        )
    $depts += @('0')

    $endpoint  = 'Tickets/TicketStatus'

    # HTTP parameters
    $paramies  = @{
        method = 'GET'
        uri    = @($($script:config.server, $endpoint -join '/'), $(new-signature)) -join '&'
    }

    # GET /Tickets/TicketStatus; Return only Matching Department ID's.
    invoke-restmethod @paramies `
        | convertto-kayakoobject `
        | where-object { $_.departmentid -in $depts }

}