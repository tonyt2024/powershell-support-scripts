# export-installed-programs.ps1
# Exports installed programs (32/64-bit) to CSV on Desktop
$items = @()
$paths = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall",
         "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
foreach ($p in $paths) {
  Get-ChildItem $p -ErrorAction SilentlyContinue | ForEach-Object {
    $d = Get-ItemProperty $_.PsPath -ErrorAction SilentlyContinue
    if ($d.DisplayName) {
      $items += [pscustomobject]@{
        Name    = $d.DisplayName
        Version = $d.DisplayVersion
        Publisher = $d.Publisher
        InstallDate = $d.InstallDate
      }
    }
  }
}
$dest = Join-Path ([Environment]::GetFolderPath('Desktop')) 'InstalledPrograms.csv'
$items | Sort-Object Name | Export-Csv $dest -NoTypeInformation
Write-Host "Saved: $dest"
