 [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Saisir le clientID/Secret, qui seront codés en B64 
$ClientIDS="SandBoxOpenam_M2M:SandBoxOpenam_M2M"
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($ClientIDS)
$EncodedText =[Convert]::ToBase64String($Bytes)


 #Login mot de passe du compte de service RID
$username = "FederationIdentite_SandBox"
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
$return = Invoke-RestMethod -Method Post -URI "https://idp-dev.sncf.fr/openam/oauth2/M2M/access_token" -Headers $headers -Body $body
$return

$bearer = 'Bearer '+$return.access_token;
$headersUserinfo = @{
    'Authorization' = $bearer
}


echo "User Info endpoint :"
$userInf = Invoke-RestMethod -Method Post -URI "https://idp-dev.sncf.fr/openam/oauth2/M2M/userinfo" -Headers $headersUserinfo
$userInf


echo "APPEL de l'api :"

#On positionne l'ID Token dans le header d'appel de l'API
$APIbearer = 'Bearer '+$userInf.id_token;
$headersAPI = @{
    'Authorization' = $APIbearer
}
# Attention, pour une vrai API il faudra aussi un header pour l'APIKEY
$APICall = Invoke-RestMethod -Method Get -URI "https://portail3.api-np.sncf.fr/test/ROS_TEST_JWT/1.0" -Headers $headersAPI
$APICall
