C:\Program Files (x86)\NSIS\makensis.exe C:\projects\ponyc-nighly\windows\ponyc-installer.nsi

$securepassword = ConvertTo-SecureString $env:BINTRAY_TOKEN -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($env:BINTRAY_USER, $securepassword)
$PONY_VERSION = Get-Date -format yyyyMMdd

Invoke-WebRequest -Uri "https://api.bintray.com/packages/$BINTRAY_USER/osx/ponyc-nightly/versions" -Body "{"name": "'$PONY_VERSION'","desc": "This is the ponyc nightly"}" -Credential $credentials -Method Post -ContentType "application/json"

Invoke-WebRequest -Uri "https://api.bintray.com/content/$env:BINTRAY_USER/windows/ponyc-nightly/$PONY_VERSION/" -Credential $credentials -Method Post -InFile "ponyc-installer.exe"