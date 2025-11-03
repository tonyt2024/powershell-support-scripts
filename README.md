# PowerShell Support Scripts
Useful PowerShell scripts for IT support, automation, and troubleshooting.

## Scripts
- **check-services.ps1** – List services by status with start type/logon.
- **collect-system-logs.ps1** – Build a zipped support bundle (system info, event logs, network).
- **network-reset.ps1** – Flush DNS, reset Winsock/IP, bounce adapters.
- **export-installed-programs.ps1** – Export installed applications to CSV.

## How to run
1. Open **PowerShell** as **Administrator**.
2. If needed, allow scripts for the session:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
