function Get-TicketPost{
    param(
        [parameter(mandatory=$true,position=0)][alias('id')][string]$TicketID
    )

    # HTTP Parameters
    $paramies   = @{
        method  = 'GET'
        uri     = @($($script:config.server, 'Tickets/TicketPost/listall', $ticketid -join '/'), $(new-signature)) -join '&'
    }

    invoke-restmethod @paramies | convertto-kayakoobject

}