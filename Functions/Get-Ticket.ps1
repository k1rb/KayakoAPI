function Get-Ticket{
    [cmdletbinding(defaultparametersetname='d')]
    param(

        # Get all tickets by department and status.
        [parameter(parametersetname='d',mandatory=$true,position=0)][string]$Department,
        [parameter(parametersetname='d',position=1)][string]$Status,
    
        # Get a single ticket by id.
        [parameter(parametersetname='i',mandatory=$true,position=0)][string]$TicketID
    
    )

    # For a single ticket, this is the URL
    if($ticketid){

        $url = @($script:config.server, 'Tickets/Ticket', $ticketid) -join '/'

    # Build URL using `ListAll`, department id, and optional ticket status
    }else{

        # Resolve Department Title to ID
        $d = get-ticketdepartment `
            | where-object { $_.title -eq $department } `
            | select-object -expand id
        if($d){
            $url = @($script:config.server,'Tickets/Ticket/ListAll',$d)
        } else { break }

        if($status){
            # Resolve TicketStatus Title to ID
            $s = get-ticketstatus $department `
                | where-object { $_.title -eq $status } `
                | select-object -expand id
            if($s){
                $url += @($s)
            } else { break }
        }

        $url = $url -join '/'

    }

    # HTTP Parameters
    $paramies   = @{
        method  = 'GET'
        uri     = @($url, $(new-signature)) -join '&'
    }

    # GET /Tickets/Ticket/*
    $response = invoke-restmethod @paramies 
    if($response){ return $response | convertto-kayakoobject }

}