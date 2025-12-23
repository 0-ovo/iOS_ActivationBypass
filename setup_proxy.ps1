# iOS Activation Bypass - Windows iProxy Setup Script
# Run this in PowerShell as Administrator

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "iOS Activation Bypass - Proxy Setup" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check if libimobiledevice directory exists
if (-Not (Test-Path ".\iproxy.exe")) {
    Write-Host "[!] iproxy.exe not found in current directory" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please ensure you've extracted libimobiledevice.1.2.1-r1122-win-x64.zip" -ForegroundColor Yellow
    Write-Host "and are running this script from that directory." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Download from:" -ForegroundColor Yellow
    Write-Host "https://github.com/libimobiledevice-win32/imobiledevice-net/releases/download/v1.3.17/libimobiledevice.1.2.1-r1122-win-x64.zip" -ForegroundColor Yellow
    exit 1
}

Write-Host "[*] Starting iProxy..." -ForegroundColor Green
Write-Host "    Local Port: 22" -ForegroundColor Gray
Write-Host "    Device SSH Port: 44" -ForegroundColor Gray
Write-Host ""
Write-Host "[*] Keep this window open!" -ForegroundColor Yellow
Write-Host "[*] Open a new PowerShell window to connect via SSH" -ForegroundColor Yellow
Write-Host ""
Write-Host "SSH Connection Command:" -ForegroundColor Cyan
Write-Host "    ssh root@127.0.0.1" -ForegroundColor White
Write-Host "    Password: alpine" -ForegroundColor White
Write-Host ""
Write-Host "Press Ctrl+C to stop the proxy when done." -ForegroundColor Gray
Write-Host ""

# Start iProxy
.\iproxy.exe 22 44
