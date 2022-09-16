function Get-TicketNote{
    param(
        [parameter(mandatory=$true,position=0)][alias('id')][string]$TicketID
    )

    $endpoint   = 'Tickets/TicketNote/ListAll'

    # HTTP Parameters
    $paramies   = @{
        method  = 'GET'
        uri     = @($($script:config.server, $endpoint, $ticketid -join '/'), $(new-signature)) -join '&'
    }

    # GET /Tickets/TicketNote/ListAll/$ticketid$
    $response = invoke-restmethod @paramies
    foreach($note in $response.notes.note){

        [pscustomobject]@{
            'type'             = $note.type
            'id'               = $note.id
            'ticketid'         = $note.ticketid
            'notecolor'        = $note.notecolor
            'creatorstaffid'   = $note.creatorstaffid
            'forstaffid'       = $note.forstaffid
            'creatorstaffname' = $note.creatorstaffname
            'creationdate'     = $script:config.epoch.addseconds($note.creationdate).addhours($script:config.tz_offset)
            'contents'         = $note.'#cdata-section'
        }

    }

}
