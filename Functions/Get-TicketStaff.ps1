function Get-TicketStaff{
    param(
        [parameter()][alias('Name')][string]$Fullname='*'
    )

    # HTTP parameters
    $paramies   = @{
        method  = 'GET'
        uri     = @($($script:config.server, 'Base/Staff' -join '/'), $(new-signature)) -join '&'
    }

    # GET /Base/Staff
    invoke-restmethod @paramies `
        | convertto-kayakoobject `
        | where-object { $_.fullname -like "$fullname" }

}