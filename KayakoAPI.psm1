# Dot source functions
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

# Create Config
$script:config = @{
    'server' = ''
    'apikey' = ''
    'secret' = ''
    'offset' = (get-timezone).baseutcoffset.hours
}

# Read and parse the secret into the config
foreach($line in $(get-content $psscriptroot\secret | where-object { $_ -notmatch '^#.*$' -and $_ })){
    switch($line.split('=')[0].trim("`"'/ ")){
        'server'    { $script:config.server = $line.split('=')[1].trim("`"'/ "), 'api/index.php?' -join '/' }
        'apikey'    { $script:config.apikey = $line.split('=')[1].trim("`"'/ ") }
        'secret'    { $script:config.secret = $line.split('=')[1].trim("`"'/ ") }
        default     { write-error 'Invalid secret file.' ; break }
    }
}

# Set TLS version 1.2
[net.servicepointmanager]::securityprotocol = [net.securityprotocoltype]::tls12
