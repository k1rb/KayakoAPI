# KayakoAPI

Powershell 5.1+ Module for Kayako Fusion (Classic)

## Requirements

- Powershell 5.1+ (including Powershell core)
- Kayako Fusion *"Classic"* version 4.40+
- Rest API enabled and configured

*Note: Most of the module will work for Kayako Fusion 4.01, some specific function parameters require 4.40+.*

## Implimentation

Most of the API is covered in some way, some functions have missing parameters. It isn't my goal to get to :100:. If you need something added submit a feature request.

| Function Name           | Description                                           |
|-------------------------|-------------------------------------------------------|
| Export-TicketAttachment | Save attachment by given ticket ID and attachment ID  |
| Get-Ticket              | Get ticket object by ID or list by department         |
| Get-TicketAttachments   | Get all ticket attachments                            |
| Get-TicketDepartment    | Get all department objects                            |
| Get-TicketNote          | Get all ticket note objects for a given ticket ID     |
| Get-TicketPost          | Get ticket posts by ticket ID                         |
| Get-TicketPriorty       | Get ticket priorities                                 |
| Get-TicketStaff         | Get staff objects                                     |
| Get-TicketStatus        | Get all ticket statuses for a given department        |
| Get-TicketType          | Get ticket types with optional department filter      |
| New-Ticket              | Create ticket                                         |
| New-TicketNote          | Create ticket note with ticket ID, contant, and staff |
| Search-Ticket           | Search Tickets for string in specified fields         |
| Remove-Ticket           | Delete ticket by ticket ID or ticket object           |
| Remove-TicketNote       | Delete ticket note by ticket ID and note ID           |
| Resolve-Ticket*ID       | Helper functions to resolve names to ticket ID        |
| Set-Ticket              | Update existing ticket information by ticket ID       |

## Usage

### Getting Started

1. Download the repository.
2. Create `secret` file in module root as shown below.
3. Save module to a path or import in-place.

**Your `secret` file should look like this:**

***Note:** For server use protocol (https) and host (domain) only.*

```text
server=https://myserver.mydomain.com
secret=<your secret>
apikey=<your api key>
```

### Usage Examples

Create a note and then immediately delete it, because why not?

```powershell
$Note = @{
    TicketID = 121231
    StaffID  = 2
    Color    = 'Pink'
    Contents = @"# To Do ($(get-date -format yyyy-MM-dd)):
1. Create multiline comment example in README.md
2. Commit
3. Push
"@
}

New-TicketNote @Note | Remove-TicketNote
```

Close tickets by tag using search (would not recommend).

```powershell
foreach($ticket in $(Search-Ticket -Query 'not-supported' -InTags)){
    Set-Ticket -TicketID $ticket.id -Status 'Closed'
}
```

Delete tickets in given department created by `boss@domain.tld` with subject "FW:\*".

```powershell
Get-Ticket -Department 'User Issues' `
    | Where-Object { $_.email -eq 'boss@domain.tld' -and $_.subject -like "fw:*" } `
    | Remove-Ticket
```

## Authors

- **Bradd Roberson** - *Author, Maintainer* - [Github][1]

## Related

- [Kayako REST API Documenation][2]

[1]: https://github.com/k1rb
[2]: https://classichelp.kayako.com/hc/en-us/articles/360006459839-Kayako-REST-API

[//]: # " requires "
