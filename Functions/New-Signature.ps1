function New-Signature{

    # Add system.web framework for url encoding the signature.
    add-type -assemblyname system.web

    # Generate HMAC Signature
    $salt           = get-random
    $hmac           = new-object system.security.cryptography.hmacsha256
    $hmac.key       = [text.encoding]::ascii.getbytes($script:config.secret)
    $signature      = [convert]::tobase64string($hmac.computehash([text.encoding]::ascii.getbytes($salt)))
    $signature      = [system.web.httputility]::urlencode($signature)

    # Return single string like: apikey=...&salt=...&signature=...
    return "apikey=$($script:config.apikey)", "salt=$salt", "signature=$signature" -join '&'

}