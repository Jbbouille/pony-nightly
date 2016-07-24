cd 'C:\Program Files (x86)\NSIS\'
.\makensis.exe C:\projects\ponyc-nighly\windows\ponyc-installer.nsi

$userPassword = "${env:BINTRAY_USER}:${env:BINTRAY_TOKEN}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($userPassword)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"
$headers = @{ Authorization = $basicAuthValue }

$PONY_VERSION = Get-Date -format yyyyMMdd

$hash = @{  name = $PONY_VERSION; 
            desc = "This is the ponyc nightly"
            }

$JSON = $hash | convertto-json 

$uriVersion = "https://api.bintray.com/packages/"+${env:BINTRAY_USER}+"/windows/ponyc-nightly/versions"
$uriPostFile = "https://api.bintray.com/content/"+${env:BINTRAY_USER}+"/windows/ponyc-nightly/"+$PONY_VERSION+"/"

Invoke-WebRequest -Uri $uriVersion -Body $JSON -ContentType "application/json" -Headers $headers -Method Post
Invoke-WebRequest -Uri $uriPostFile -Headers $headers -InFile "C:\projects\ponyc-nighly\windows\ponyc-installer.exe" -Method Post

