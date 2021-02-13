function Get-TicketDepartment{
    param(
        [parameter(position=0)][string]$Department='*'
    )

    # HTTP Parameters
    $paramies   = @{
        method  = 'GET'
        uri     = @($($script:config.server, 'Base/Department' -join '/'), $(new-signature)) -join '&'
    }

    # GET /Base/Department (ListAll)
    invoke-restmethod @paramies `
        | convertto-kayakoobject `
        | where-object { $_.title -like "$department" }

}