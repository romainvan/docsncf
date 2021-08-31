[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Saisir le clientID/Secret, qui seront envoyés dans le Body
$client_id = 'SandBoxOpenam_POST'
$client_secret = 'SandBoxOpenam_POST'


# Avant de tester le script, il faut récupérer le jeton d'accès et modifier la variable "auto" 

# URL d'autorisation : https://idp-dev.sncf.fr/openam/oauth2/IDP/authorize?realm=IDP&response_type=code&client_id=SandBoxOpenam_POST&scope=profile%20openid%20roles&redirect_uri=http%3A%2F%2Flocalhost%3A8080


#Variable pour l'appel de l'access
$auto = 'eb443832-3823-49cf-b909-3591088f5590';
$headers = @{
    'Content-Type' = 'application/x-www-form-urlencoded'
}

$Body = @{
    'grant_type' = 'authorization_code'
    'client_id' = $client_id
    'client_secret' = $client_secret
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
