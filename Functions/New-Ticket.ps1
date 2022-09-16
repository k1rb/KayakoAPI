function New-Ticket{
    [cmdletbinding(defaultparametersetname='auto')]
    param(
        [parameter(mandatory=$true)][string]$Subject,
        [parameter(mandatory=$true)][string]$FullName,
        [parameter(mandatory=$true)][string]$Email,
        [parameter(mandatory=$true)][string]$Contents,
        [parameter(mandatory=$true)][string]$DepartmentID,
        [parameter(mandatory=$true)][string]$TicketStatusID,
        [parameter(mandatory=$true)][string]$TicketPriorityID,
        [parameter(mandatory=$true)][string]$TicketTypeID,
        [parameter(parametersetname='auto',mandatory=$true)][switch]$autouserid,
        [parameter(parametersetname='user',mandatory=$true)][switch]$userid,
        [parameter(parametersetname='staf',mandatory=$true)][switch]$staffid,
        [parameter()][string]$OwnerStaffID,
        [parameter()][validateset('Default','Phone')][string]$Type,
        [parameter()][string]$TemplateGroup,
        [parameter()][switch]$IgnoreAutoResponder,
        [parameter()][string]$EmailQueueID
    )

    # Prepair POST Parameters
    add-type -assemblyname system.web
    # Mandatory Parameters
    $collection += @(
        $(new-signature),
        "subject=$([system.web.httputility]::urlencode($subject))",
        "fullname=$([system.web.httputility]::urlencode($fullname))",
        "email=$([system.web.httputility]::urlencode($email))",
        "contents$([system.web.httputility]::urlencode($contents))",
        "departmentid=$departmentid",         # get-ticketdepartment | select-object id, title
        "ticketstatusid=$ticketstatusid",     # get-ticketstatus $department | select-object id, title
        "ticketpriorityid=$ticketpriorityid", # get-ticketpriority | select-object id, title
        "tickettypeid=$tickettypeid"          # get-tickettype | select-object id, title
        )
    # Optional Parameters
    if($autouserid){          $collection += 'autouserid', '1' -join '='                }
    if($userid){              $collection += 'userid', $userid -join '='                }
    if($staffid){             $collection += 'staffid', $staffid -join '='              }
    if($ownerstaffid){        $collection += 'ownerstaffid', $ownerstaffid -join '='    }
    if($type){                $collection += 'type', $type -join '='                    }
    if($ignoreautoresponder){ $collection += 'ignoreautoresponder', '1' -join '='       }
    if($templategroup){ 
        $collection += @(
            'templategroup',
            [system.web.httputility]::urlencode($templategroup)
         ) -join '='
    }

    $endpoint   = 'Tickets/Ticket'

    # HTTP Parameters (POST)
    $paramies   = @{
        method  = 'POST'
        headers = @{ 'Content-Type' = 'application/x-www-form-urlencoded' }
        uri     = $script:config.server, $endpoint -join '/'
        body    = $collection -join '&'
    }

    # POST /Tickets/Ticket (POST)
    invoke-restmethod @paramies | convertto-kayakoobject

}