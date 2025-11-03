# check-services.ps1
# Lists services by status (Running/Stopped) with start type and logon
param(
  [ValidateSet('Running','Stopped','All')]
  [string]$Status = 'Running'
)

$services = Get-WmiObject Win32_Service |
  Select-Object Name, DisplayName, State, StartMode, StartName

switch ($Status) {
  'Running' { $services = $services | Where-Object State -eq 'Running' }
  'Stopped' { $services = $services | Where-Object State -eq 'Stopped' }
  default   { }
}

$services | Sort-Object DisplayName | Format-Table -Auto
