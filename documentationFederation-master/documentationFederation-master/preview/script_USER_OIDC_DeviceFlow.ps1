########################################
## Exemple de Device flow avec AM 6.5 ##
########################################
# - Attention l'UI utilisateur n'est à ce jour au théme SNCF et le rendu est donc pas bon
# - ceci est un POC Non suporté pour le moment par les equipes

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


# https://datatracker.ietf.org/doc/html/rfc8628
# https://backstage.forgerock.com/docs/am/6/oauth2-guide/#rest-api-oauth2-device-flow

$client_id = "sncf.id.sandbox.app";
$client_secret = "sncf.id.sandbox.app";

# Préparation du header authorisation
$ClientIDS="$($client_id):$($client_secret)"
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($ClientIDS)
$EncodedText =[Convert]::ToBase64String($Bytes)
$headers = @{
    'Content-Type' = 'application/x-www-form-urlencoded'
    'Authorization' = "Basic $EncodedText"
}
$headers



# definition des end point utiles
$endpoint_device = "https://idp-pdev-eks.sncf.fr/openam/oauth2/realms/root/realms/IDP/device/code";
$endpoint_token  = "https://idp-pdev-eks.sncf.fr/openam/oauth2/realms/root/realms/IDP/access_token";


##### 1. obtenir une url d'authentification (idéalement à faire coté serveur pour éviter le client_secret pour la suite des echanges)

$postParams = @{
                client_id=$client_id;
                response_type='device_code'; # hors norme (Oauth 2.1)
                nonce='1'; # hors norme (Oauth 2.1)
                scope='openid';
                acr_values='authforte'; ## Authentification forte 
               }
try {
    $devicecode_json = Invoke-WebRequest -Uri $endpoint_device -Method POST -Headers $headers -Body $postParams -ErrorAction Continue
    $devicecode = ($devicecode_json.Content | ConvertFrom-Json)
} catch { 
        $result = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($result)
        $reader.BaseStream.Position = 0
        $reader.DiscardBufferedData()
        $err = $reader.ReadToEnd();
        $err
    exit
}
$devicecode

# AM ne créer la l'url complete ....
$verification_uri_complete = $devicecode.verification_uri+"?user_code="+$devicecode.user_code


##### 2. on ouvre le navigateur par defaut à l'url d'authentification
Start-Process $verification_uri_complete

##### 2'. OU on propose le lien et le code et pourquoi pas générer un QRcode :)
write-host "Rendez-vous sur : " $devicecode.verification_uri -ForegroundColor DarkCyan -BackgroundColor Yellow
write-host "Saisiez le code : " $devicecode.user_code -ForegroundColor DarkCyan -BackgroundColor Yellow
write-host "Ou Scanner le QRcode : " $verification_uri_complete -ForegroundColor DarkCyan -BackgroundColor Yellow



# 3. on poll sur l'url token
$post = @{
        grant_type="urn:ietf:params:oauth:grant-type:device_code";
        device_code=$devicecode.device_code;
};
$token = ""
$userTokens = "";
# ici on reprend le temps du polling
$pollTime = $devicecode.interval;
$pollTime -= 2; # on diminue volontairement le temps pour voir le slow_down en action
 


while ($userTokens -eq "") {
    try {
        $token_json =  Invoke-WebRequest -Uri $endpoint_token -Method POST -Headers $headers -Body $post
        $token = ($token_json.Content | ConvertFrom-Json)
    } catch { 
        $result = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($result)
        $reader.BaseStream.Position = 0
        $reader.DiscardBufferedData()
        $token = ($reader.ReadToEnd() | ConvertFrom-Json)
        
    }
     
    if ($token.error) {
        write-host "polling : " $token.error_description -ForegroundColor DarkBlue -BackgroundColor White
        switch ( $token.error )
            {
                "authorization_pending" { 
                    Sleep $pollTime; 
                    }
                "slow_down" {  
                    $pollTime += 5 # +5 secondes défini dans la norme
                    Sleep $pollTime;    
                    }
                "access_denied" { 
                    write-host $token -ForegroundColor red -BackgroundColor White
                    exit;
                   }
                "expired_token" { 
                    write-host $token -ForegroundColor red -BackgroundColor White
                    exit;
                   }
            }
        
    } elseif ($token.access_token){
        write-host "polling : Authentification OK" -ForegroundColor DarkGreen -BackgroundColor White
        $userTokens = $token
    } else {
        "Erreur non gérée"
        $token
        Sleep $pollTime;
    }
}

# 4. on a les jetons et on continue comme à l'habitude
write-host "Access Tokens : " $userTokens.access_token
$userTokens
