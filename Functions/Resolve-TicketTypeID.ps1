function Resolve-TicketTypeID{
    param(
        [parameter(mandatory=$true)][string]$Type,
        [parameter(mandatory=$true)][string]$Department
    )

    get-tickettype -department $department `
        | where-object { $_.title -eq $Type } `
        | select-object -expand id

}