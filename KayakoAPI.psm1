# Stop if we don't have an API secret file
if(!(test-path "$psscriptroot\secret")){ write-error "Missing secret file." ; break }

# Dot source functions with progress...
"$psscriptroot/Functions" | foreach-object {

    $c = split-path $_ -leaf
    $i = get-childitem $_ -rec -file -inc *.ps1 | sort-object name

    if($i){
        0..$($i.count -1)| foreach-object {
            $n = ( $_ / $i.count ) * 100
            write-progress "Loading $(split-path $psscriptroot -leaf) ..." -status $c -currentoperation $i[$_].name -percentcomplete $n
            . $i[$_].fullname
        }
        write-progress "Complete!" -completed
    }

}

# Read secret and parse into config
$config = @{
    epoch = get-date '1/1/1970 5:00AM'
    tz_offset = (get-timezone).baseutcoffset.hours
    time_properties = @(
        'lastactivity'
        'creationtime'
        'nextreplydue'
        'laststaffreply'
        'lastuserreply'
        'dateline'
    )
}

foreach($line in (get-content "$psscriptroot\secret")){
    $k = $line.split('=')[0]
    $v = $line.split('=')[1..$($line.split('=').count)] -join '='
    if($k -eq 'server'){
        $proto = ($v.split('/')|?{$_})[0]
        $host  = ($v.split('/')|?{$_})[1]
        $api   = '/api/index.php?'
        $v     = "$proto//$host/$api"
    }
    $config.add($k.trim(), $v.trim())
}

if(!$config.server -or !$config.apikey -or !$config.secret){
    write-error "Invalid secret file. Must include server URL, API Key, and Secret key."
    break
}



# Set TLS version 1.2
[net.servicepointmanager]::securityprotocol = [net.securityprotocoltype]::tls12
