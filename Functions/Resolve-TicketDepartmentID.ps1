function Resolve-TicketDepartmentID{
    param(
        [parameter(mandatory=$true)][string]$Department
    )

    get-ticketdepartment -department $department `
        | select-object -expand id

}