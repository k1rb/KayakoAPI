# KayakoAPI

Powershell 5.1+ Module for Kayako Fusion (Classic)

## Requirements

- Powershell 5.1+ (including 7.0)
- Kayako Fusion *"Classic"* version 4.40+
- Rest API enabled and configured

*Note: Most of the module will work for Kayako Fusion 4.01, some specific parameters require 4.40+.*

## Implimentation

Most of the API is covered in some way, some functions have missing parameters. It isn't my goal to get to :100:. If you need something added submit a feature request.

| Function Name         | Description                                          |
|-----------------------|------------------------------------------------------|
| Get-Ticket            | Get Ticket Object by ID or List by Department        |
| Get-TicketDepartment  | Get All Department Objects                           |
| Get-TicketNote        | Get All Ticket Note Objects for a given Ticket ID    |
| Get-TicketPost        | Get Ticket Posts by Ticket ID                        |
| Get-TicketPriorty     | Get Ticket Priorities                                |
| Get-TicketStaff       | Get Staff Objects                                    |
| Get-TicketStatus      | Get All Ticket Statuses for a given Department       |
| Get-TicketType        | Get Ticket Types with optional department filter     |
| New-Ticket            | Create Ticket                                        |
| New-TicketNote        | Create Ticket Note with TicketID, Contant, and Staff |
| Search-Ticket         | Search Tickets for string in specified fields        |
| Remove-Ticket         | Delete Ticket by TicketID or Ticket Object           |
| Remove-TicketNote     | Delete Ticket Note by TicketID and NoteID            |
| Resolve-Ticket*ID     | Helper functions to resolve names to id's            |
| Set-Ticket            | Update existing ticket information by Ticket ID      |

## Usage

### Getting Started

1. Download the repository.
2. Create `secret` file in module root as shown below.
3. Save module to a path or import in-place.

**Your `secret` file should look like this:**

```text
server=https://myserver.mydomain.com
secret=<your secret>
apikey=<your api key>
```

### Examples

Common usage and workflow examples:

```powershell
# Create a note and then immediately delete it because why not?
$Parameters  = @{
    TicketID = 121231
    Contents = "1. Multiline`n2. Comment`n3. Example"
    StaffID  = 2
    Color    = 'Pink'
}
New-TicketNote @Parameters | Remove-TicketNote

# Close tickets by tag, using search... don't actually do this.
Search-Ticket -Query 'not-supported' -InTags | foreach-object { 
    Set-Ticket -TicketID $_.id -status 'Closed'
}

# Get tickets by department, sent by boss, subject "fw:*", delete.
Get-Ticket -Department 'User Issues' | where-object {
    $_.email -eq 'myboss@mycompany.com' -and
    $_.subject -like "fw:*"
    } | Remove-Ticket

```

## Authors

* **Bradd Roberson** - *Intitial Work* - [k1rb](https://github.com/k1rb)

[//]: # " requires "