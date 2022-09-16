function Get-TicketDepartment{
    param(
        [parameter(position=0)][string]$Department='*'
    )

    $endpoint  = 'Base/Department'

    # HTTP Parameters
    $paramies  = @{
        method = 'GET'
        uri    = @($($script:config.server, $endpoint -join '/'), $(new-signature)) -join '&'
    }

    # GET /Base/Department (ListAll)
    invoke-restmethod @paramies `
        | convertto-kayakoobject `
        | where-object { $_.title -like "$department" }

}