function Set-Ticket{
    [cmdletbinding()]
    param(
        [parameter(mandatory=$true,position=0)][alias('Id')][string]$TicketID,
        [parameter()][alias('Subject')][string]$TicketSubject,
        [parameter()][alias('Status')][string]$TicketStatus,
        [parameter()][alias('Name')][string]$FullName,
        [parameter()][string]$Email,
        [parameter()][alias('Owner')][string]$TicketOwner,
        [parameter()][alias('PriorityID')][string]$TicketPriorityID,
        [parameter()][alias('TypeID')][string]$TicketTypeID
    )

    # Prepair POST Parameters
    add-type -assemblyname system.web
    $collection = @( new-signature )
    if($ticketsubject){    $collection += 'subject', [system.web.httputility]::urlencode($ticketsubject) -join '='                                 }
    if($fullname){         $collection += 'fullname', [system.web.httputility]::urlencode((get-culture).textinfo.totitlecase($fullname)) -join '=' }
    if($email){            $collection += 'email', [system.web.httputility]::urlencode($email.tolower()) -join '='                                 }
    if($ticketowner){      $collection += 'ownerstaffid', $(get-ticketstaff $ticketowner).id -join '='                                             }
    if($ticketstatus){     $collection += 'ticketstatusid', $(get-ticketstatus $ticketstatus).id -join '='                                         }
    # No help for now, get ID's with Get-Ticket{Type,Priority}
    if($ticketpriorityid){ $collection += 'ticketpriorityid', $ticketpriorityid -join '='                                                          }
    if($tickettypeid){     $collection += 'tickettypeid', $tickettypeid -join '='                                                                  }

    $endpoint   = 'Tickets/Ticket'

    # HTTP Parameters (POST)
    $paramies   = @{
        method  = 'PUT'
        headers = @{ 'Content-Type' = 'application/x-www-form-urlencoded' }
        uri     = $script:config.server, $endpoint, $ticketid -join '/'
        body    = $collection -join '&'
    }

    # PUT /Tickets/Ticket/$id (POST)
    invoke-restmethod @paramies | convertto-kayakoobject

}