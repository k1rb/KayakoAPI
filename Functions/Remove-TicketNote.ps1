function Remove-TicketNote{
    [cmdletbinding(defaultparametersetname='params')]
    param(
        # Default Requires TicketID, NoteID
        [parameter(
            parametersetname='params',
            mandatory=$true,
            position=0
        )][string]$TicketID,
        [parameter(
            parametersetname='params',
            mandatory=$true,
            position=1
        )][string]$NoteID,

        # If you have a Note Object, feed it through
        [parameter(
            valuefrompipeline=$true,
            parametersetname='object',
            mandatory=$true
        )][object]$Note
    )

    # Extract TicketID, NoteID from Note Object
    if($note){
        $ticketid = $note.ticketid
        $noteid   = $note.id
        if(!$ticketid -or !$noteid){ return }
    }

    $endpoint   = 'Tickets/TicketNote'

    # HTTP Parameters
    $paramies   = @{
        method  = 'DELETE'
        uri     = @($($script:config.server, $endpoint, $ticketid, $noteid -join '/'), $(new-signature)) -join '&'
    }

    # DELETE /Tickets/TicketNote/$ticketid/$noteid
    invoke-restmethod @paramies

}