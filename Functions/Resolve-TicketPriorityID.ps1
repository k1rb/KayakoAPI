function Resolve-TicketPriorityID{
    param(
        [parameter(mandatory=$true)][string]$Priority
    )

    get-ticketpriority `
        | where-object { $_.title -eq $priority } `
        | select-object -expand id

}