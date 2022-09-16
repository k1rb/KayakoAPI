function Remove-Ticket{
    [cmdletbinding(defaultparametersetname='params')]
    param(
        # Default Requires TicketID
        [parameter(
            parametersetname='params',
            mandatory=$true,
            position=0
        )][string]$TicketID,

        # If you have a Note Object, feed it through
        [parameter(
            valuefrompipeline=$true,
            parametersetname='object',
            mandatory=$true
        )][object]$Ticket
    )

    # Extract TicketID from Ticket Object
    if($ticket){
        $ticketid = $ticket.id
        if(!$ticketid){ return }
    }

    $endpoint  = 'Tickets/Ticket'

    # HTTP Parameters
    $paramies  = @{
        method = 'DELETE'
        uri    = @($($script:config.server, $endpoint, $ticketid -join '/'),$(new-signature)) -join '&'
    }

    # DELETE /Tickets/Ticket/$ticketid
    invoke-restmethod @paramies

}