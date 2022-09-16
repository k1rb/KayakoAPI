function Search-Ticket{
    param(
        [parameter(mandatory=$true)][string]$Query,
        [parameter()][switch]$InTicketID,
        [parameter()][switch]$InContents,
        [parameter()][switch]$InAuthor,
        [parameter()][switch]$InEmail,
        [parameter()][switch]$InCreatorEmail,
        [parameter()][switch]$InFullName,
        [parameter()][switch]$InNotes,
        [parameter()][switch]$InUserGroup,
        [parameter()][switch]$InUserOrganization,
        [parameter()][switch]$InUser,
        [parameter()][switch]$InTags
    )

    # Prepair POST Parameters
    add-type -assemblyname system.web
    # Mandatory Parameters
    $collection += @(
        $(new-signature),
        $('query', [system.web.httputility]::urlencode($query) -join '=')
    )
    # Optional Parameters
    if($InTicketID){         $collection += 'ticketid', '1' -join '='           }
    if($InContents){         $collection += 'contents', '1' -join '='           }
    if($InAuthor){           $collection += 'author', '1' -join '='             }
    if($InEmail){            $collection += 'email', '1' -join '='              }
    if($InCreatorEmail){     $collection += 'creatoremail', '1' -join '='       }
    if($InFullName){         $collection += 'fullname', '1' -join '='           }
    if($InNotes){            $collection += 'notes', '1' -join '='              }
    if($InUserGroup){        $collection += 'usergroup', '1' -join '='          }
    if($InUserOrganization){ $collection += 'userorganization', '1' -join '='   }
    if($InUser){             $collection += 'user', '1' -join '='               }
    if($InTags){             $collection += 'tags', '1' -join '='               }

    $endpoint   = 'Tickets/TicketSearch'

    # HTTP Parameters (POST)
    $paramies   = @{
        method  = 'POST'
        headers = @{ 'Content-Type' = 'application/x-www-form-urlencoded' }
        uri     = $script:config.server, $endpoint -join '/'
        body    = $collection -join '&'
    }

    # POST /Tickets/TicketSearch
    invoke-restmethod @paramies | convertto-kayakoobject

}