function Get-TicketPost{
    param(
        [parameter(mandatory=$true,position=0)][alias('id')][string]$TicketID
    )

    $endpoint  = 'Tickets/TicketPost/listall'

    # HTTP Parameters
    $paramies  = @{
        method = 'GET'
        uri    = @($($script:config.server, $endpoint, $ticketid -join '/'), $(new-signature)) -join '&'
    }

    invoke-restmethod @paramies | convertto-kayakoobject

}