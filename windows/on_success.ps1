cd 'C:\Program Files (x86)\NSIS\'
.\makensis.exe C:\projects\ponyc-nighly\windows\ponyc-installer.nsi

$securepassword = ConvertTo-SecureString $env:BINTRAY_TOKEN -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($env:BINTRAY_USER, $securepassword)
$PONY_VERSION = Get-Date -format yyyyMMdd

$hash = @{  name    = $PONY_VERSION; 
            desc = "This is the ponyc nightly"
            }

$JSON = $hash | convertto-json 

Invoke-WebRequest -Uri "https://api.bintray.com/packages/"+${env:$BINTRAY_USER}+"/windows/ponyc-nightly/versions" -Body $JSON -Credential $credentials -Method Post -ContentType "application/json"
Invoke-WebRequest -Uri "https://api.bintray.com/content/"+${env:BINTRAY_USER}+"/windows/ponyc-nightly/"+$PONY_VERSION+"/" -Credential $credentials -Method Post -InFile "C:\projects\ponyc-nighly\windows\ponyc-installer.exe"

