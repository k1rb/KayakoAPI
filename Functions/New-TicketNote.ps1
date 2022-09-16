function New-TicketNote{
    [cmdletbinding(defaultparametersetname='name')]
    param(
        [parameter(mandatory=$true,position=0)][string]$TicketID,
        [parameter(mandatory=$true)][string]$Contents,
        [parameter(mandatory=$true,parametersetname='name')][string]$StaffFullname,
        [parameter(mandatory=$true,parametersetname='id')][string]$StaffID,
        [parameter()][validateset('Yellow','Pink')]$Color='Yellow'
    )

    # Prepair POST Parameters
    add-type -assemblyname system.web
    $collection += @( $(new-signature), "ticketid=$ticketid" )
    $collection += @( 'contents', [system.web.httputility]::urlencode($contents) -join '=' )
    if($stafffullname){ $collection += 'fullname', [system.web.httputility]::urlencode($stafffullname) -join '=' }
    if($staffid){       $collection += 'staffid', $staffid -join '=' }
    if($color){
        $notecolor = switch($color){
            'pink'  { '2' }
            default { '1' }
        }
        $collection += 'notecolor', $notecolor -join '='
    }

    $endpoint   = 'Tickets/TicketNote'

    # HTTP Parameters (POST)
    $paramies   = @{
        method  = 'POST'
        headers = @{ 'Content-Type' = 'application/x-www-form-urlencoded' }
        uri     = $script:config.server, $endpoint -join '/'
        body    = $collection -join '&'
    }

    # POST /Tickets/TicketNote/$ticketid
    invoke-restmethod @paramies | convertto-kayakoobject

}