function Get-TicketPriority{
    param(
        [parameter()][string]$Priority='*'
    )

    # HTTP parameters
    $paramies   = @{
        method  = 'GET'
        uri     = @($($script:config.server, 'Tickets/TicketPriority' -join '/'), $(new-signature)) -join '&'
    }

    # GET /Tickets/TicketPriority
    invoke-restmethod @paramies | convertto-kayakoobject

}