function Get-TicketPriority{
    param(
        [parameter()][string]$Priority='*'
    )

    $endpoint  = 'Tickets/TicketPriority'

    # HTTP parameters
    $paramies  = @{
        method = 'GET'
        uri    = @($($script:config.server, $endpoint -join '/'), $(new-signature)) -join '&'
    }

    # GET /Tickets/TicketPriority
    invoke-restmethod @paramies | convertto-kayakoobject

}