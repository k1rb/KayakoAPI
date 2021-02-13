function Get-TicketNote{
    param(
        [parameter(mandatory=$true,position=0)][alias('id')][string]$TicketID
    )

    # HTTP Parameters
    $paramies   = @{
        method  = 'GET'
        uri     = @($($script:config.server, 'Tickets/TicketNote/ListAll', $ticketid -join '/'), $(new-signature)) -join '&'
    }

    # GET /Tickets/TicketNote/ListAll/$ticketid$
    $response = invoke-restmethod @paramies
    foreach($note in $response.notes.note){

        # Return each as PSCustomObject
        [pscustomobject]@{
            'type'             = $note.type
            'id'               = $note.id
            'ticketid'         = $note.ticketid
            'notecolor'        = $note.notecolor
            'creatorstaffid'   = $note.creatorstaffid
            'forstaffid'       = $note.forstaffid
            'creatorstaffname' = $note.creatorstaffname
            'creationdate'     = (get-date -date '1/1/1970 5:00 AM').addseconds($note.creationdate).addhours($script:config.tz)
            'contents'         = $note.'#cdata-section'
        }

    }

}