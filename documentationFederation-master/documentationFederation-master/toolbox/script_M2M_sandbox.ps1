[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Saisir le clientID/Secret, qui seront codés en Base64
$ClientIDS="SandBoxOpenam_M2M:SandBoxOpenam_M2M"
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($ClientIDS)
$EncodedText =[Convert]::ToBase64String($Bytes)


#Login mot de passe du compte de service RID
$username = 'FederationIdentite_SandBox'
$password = 'SandBoxOpenam_M2M'

$headers = @{
    'Content-Type' = 'application/x-www-form-urlencoded'
    'Authorization' = "Basic $EncodedText"
} 

$body = @{
    'grant_type' = 'password'
    'username' = $username
    'password' =  $password
    'scope' = "openid login roles"
}


echo "Access token endpoint :"
$access_result = Invoke-RestMethod -Method Post -URI "https://idp-dev.sncf.fr/openam/oauth2/M2M/access_token" -Headers $headers -Body $body
$access_result
    
$bearer = 'Bearer '+$access_result.access_token;
$headersUserinfo = @{
    'Authorization' = $bearer
}


echo "User Info endpoint :"
$userInf = Invoke-RestMethod -Method Post -URI "https://idp-dev.sncf.fr/openam/oauth2/M2M/userinfo" -Headers $headersUserinfo
$userInf
