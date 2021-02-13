function Resolve-TicketStatusID{
    param(
        [parameter(mandatory=$true)][string]$Status,
        [parameter(mandatory=$true)][string]$Department
    )

    get-ticketstatus -department $department `
        | where-object { $_.title -eq $status } `
        | select-object -expand id

}