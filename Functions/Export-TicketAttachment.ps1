function Export-TicketAttachment {
    param(
        [parameter(mandatory=$true)][string]$TicketID,
        [parameter(mandatory=$true)][string]$AttachmentID,
        [parameter()][string]$FolderPath
    )

    # Error if given folder path does not exist...
    if($folderpath){
        if(!(get-item $folderpath).psiscontainer){
            write-error 'Invalid FolderPath, directory must exist.'
            break
        }
    # If folder path is not given, use current working directory
    } else {
        $folderpath = $(get-location).path
    }

    $endpoint  = 'Tickets/TicketAttachment'

    $paramies  = @{
        method = 'GET'
        uri    = @($($script:config.server, $endpoint, $ticketid,$attachmentid -join '/'), $(new-signature)) -join '&'
    }

    $data = invoke-restmethod @paramies | convertto-kayakoobject

    # Write the file out to current directory    
    if($data){
        $file_extension = $data.filename.split('.')[-1]
        $file_name = $data.filename.split('.')[0..$($data.filename.split('.').count -2)] -join '.'
        [io.file]::writeallbytes(
            $($folderpath,
            $(($file_name, $ticketid, $attachmentid -join '_'), $file_extension -join '.') -join '/'),
            $([convert]::frombase64string($data.contents))
        )
    }

}
