function ConvertTo-KayakoObject{
    param(
        [parameter(valuefrompipeline=$true,mandatory=$true)][Object]$XMLPayload
    )

    # Skin the document into an array. Result [array]$result = $input.<property>.<property>
    # Also store the last <property> as the payload type (eg. 'ticket', 'status', etc.)
    foreach($i in 0..1){
        if($i){ $payloadtype = $xmlpayload | get-member -type property | select-object -expand name }
        $xmlpayload = @( $xmlpayload."$(
            $xmlpayload `
                | get-member -type property `
                | where-object { $_.name -ne 'xml' } `
                | select-object -expand name
            )"
        )
    }

    # Break each resulting XML element down into a hashtable.
    foreach($xml in $xmlpayload){

        # Create skeleton based on payload type (currently useless)
        $skeleton = switch($payloadtype){
            default     { @{} }
        }

        # Enumerate target properties and types...
        foreach($property in $($xml | get-member | select-object name, membertype, @{n='definition';e={$_.definition.split()[0].trim()}})){

            if($property.membertype -ne 'property'){ continue }

            # If we have a XML Element...
            if($property.definition -like "*xmlelement*"){

                # If there is a CDATA section... add key, value to hashtable
                if(($xml."$($property.name)" | get-member -type property).name -eq '#cdata-section'){
                    $skeleton.add($property.name, $xml."$($property.name)".'#cdata-section')
                }

            # This is most likely an Array of non-XML Elements.
            }elseif($property.definition -eq 'System.Object[]'){

                $skeleton.add($property.name, @( $xml."$($property.name)"))

            # This is a single string or int, etc.
            }else{

                $skeleton.add($property.name, $xml."$($property.name)")

            }

        }

        # Convert these properties (seconds from Epoch 0) into datetime.
        foreach($property in $script:config.time_properties){
            if($skeleton."$property" -gt 0){
                $skeleton."$property" = $script:config.epoch.addseconds($skeleton."$property").addhours($script:config.tz_offset)
            } else {
                $skeleton."$property" = $null
            }
        }

        # If this is a ticket post, remove the <br />
        if($payloadtype -eq 'post'){
            $skeleton.contents = $skeleton.contents.replace('<br />','')
        }

        # Return object
        [pscustomobject]$skeleton

    }

}
