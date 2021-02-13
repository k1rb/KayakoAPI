function Resolve-TicketStatusID{
    param(
        [parameter(mandatory=$true)][string]$Fullname
    )

    get-ticketstaff $fullname | select-object -expand id

}