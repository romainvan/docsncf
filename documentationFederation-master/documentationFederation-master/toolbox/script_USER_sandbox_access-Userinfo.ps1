[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Saisir les clientID/Secret, qui seront codés en Base64
$client_id = 'sncf.id.sandbox.app'
$client_secret = 'sncf.id.sandbox.app'


# Avant de tester le script, il faut récupérer le jeton d'accès et modifier la variable "auto" 

# URL d'autorisation : https://idp-dev.sncf.fr/openam/oauth2/IDP/authorize?realm=IDP&response_type=code&client_id=sncf.id.sandbox.app&scope=profile%20openid%20roles&redirect_uri=http%3A%2F%2Flocalhost%3A8080


# Préparation du header authorisation
$ClientIDS="$($client_id):$($client_secret)"
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($ClientIDS)
$EncodedText =[Convert]::ToBase64String($Bytes)


#Variable pour l'appel de l'access
$auto = '84a21a5b-cc3f-4567-9e95-675bdf3bd1c6';
$headers = @{
    'Content-Type' = 'application/x-www-form-urlencoded'
    'Authorization' = "Basic $EncodedText"
}

$Body = @{
 'grant_type' = 'authorization_code'
 'code' = $auto
 'redirect_uri' = 'http://localhost:8080'
}


echo "Access token endpoint :"
$access_result = Invoke-RestMethod -Method Post -URI "https://idp-dev.sncf.fr:443/openam/oauth2/IDP/access_token" -Headers $headers -Body $body
$access_result


$bearer = 'Bearer '+$access_result.access_token;
$headersUserinfo = @{
    'Authorization' = $bearer
}

echo "User Info endpoint :"
Invoke-RestMethod -Method Post -URI "https://idp-dev.sncf.fr:443/openam/oauth2/IDP/userinfo" -Headers $headersUserinfo


$Body = @{
 'grant_type' = 'refresh_token'
 'refresh_token' = $access_result.refresh_token
 'redirect_uri' = 'http://localhost:8080'
}


echo "Access token endpoint - Refresh tokens :"
$refresh_token = Invoke-RestMethod -Method Post -URI "https://idp-dev.sncf.fr:443/openam/oauth2/IDP/access_token" -Headers $headers -Body $body
$refresh_token


$bearer = 'Bearer '+$refresh_token.access_token;
$headersUserinfo = @{
    'Authorization' = $bearer
}

echo "User Info endpoint - After refresh tokens :"
Invoke-RestMethod -Method Post -URI "https://idp-dev.sncf.fr:443/openam/oauth2/IDP/userinfo" -Headers $headersUserinfo

