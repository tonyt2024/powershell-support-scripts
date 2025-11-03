# network-reset.ps1
# Quickly resets common network components (requires admin)
Write-Host "Flushing DNS..." ; ipconfig /flushdns
Write-Host "Resetting Winsock..." ; netsh winsock reset
Write-Host "Resetting IP stack..." ; netsh int ip reset
Write-Host "Disabling & enabling adapters..."
Get-NetAdapter | Where-Object Status -eq 'Up' | Disable-NetAdapter -Confirm:$false
Start-Sleep -Seconds 3
Get-NetAdapter | Enable-NetAdapter -Confirm:$false
Write-Host "Done. A reboot may be recommended."
