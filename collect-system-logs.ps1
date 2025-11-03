# collect-system-logs.ps1
# Collects key logs and system info into C:\Temp\SupportBundle-<date>.zip
$root = "C:\Temp"
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$work = Join-Path $root "SupportBundle-$stamp"
$new = New-Item -ItemType Directory -Force -Path $work

# Basic info
systeminfo | Out-File "$work\systeminfo.txt"
Get-ComputerInfo | Out-File "$work\computerinfo.txt"

# Event logs (last 24h)
$since = (Get-Date).AddDays(-1)
Get-WinEvent -FilterHashtable @{LogName='System'; StartTime=$since} |
  Export-Csv "$work\System-24h.csv" -NoTypeInformation
Get-WinEvent -FilterHashtable @{LogName='Application'; StartTime=$since} |
  Export-Csv "$work\Application-24h.csv" -NoTypeInformation

# Network config
ipconfig /all | Out-File "$work\ipconfig.txt"
Get-NetAdapter | Format-List * | Out-File "$work\netadapters.txt"
Test-Connection 8.8.8.8 -Count 4 | Out-File "$work\ping.txt"

# Services snapshot
Get-Service | Select Name,DisplayName,Status | Export-Csv "$work\Services.csv" -NoTypeInformation

# Compress
$zip = "$root\SupportBundle-$stamp.zip"
Compress-Archive -Path "$work\*" -DestinationPath $zip -Force
Write-Host "Bundle created: $zip"
