#!/bin/bash
# iOS Activation Bypass - Linux iProxy Setup Script

echo "=========================================="
echo "iOS Activation Bypass - Proxy Setup"
echo "=========================================="
echo ""

# Check if iproxy is installed
if ! command -v iproxy &> /dev/null; then
    echo "[!] iproxy not found!"
    echo ""
    echo "Please install libimobiledevice tools:"
    echo ""
    echo "Ubuntu/Debian:"
    echo "  sudo apt update"
    echo "  sudo apt install libusbmuxd-tools libimobiledevice-utils"
    echo ""
    echo "Fedora/RHEL:"
    echo "  sudo dnf install libusbmuxd-utils libimobiledevice-utils"
    echo ""
    echo "Arch Linux:"
    echo "  sudo pacman -S libusbmuxd libimobiledevice"
    echo ""
    echo "macOS:"
    echo "  brew install libusbmuxd libimobiledevice"
    echo ""
    exit 1
fi

# Check if device is connected
echo "[*] Checking for connected devices..."
if command -v idevice_id &> /dev/null; then
    DEVICE=$(idevice_id -l 2>/dev/null | head -n 1)
    if [ -z "$DEVICE" ]; then
        echo "[!] No device detected. Please connect your jailbroken device."
        echo ""
        exit 1
    else
        echo "[✓] Device detected: $DEVICE"
        echo ""
    fi
fi

echo "[*] Starting iProxy..."
echo "    Local Port: 2222"
echo "    Device SSH Port: 44"
echo ""
echo "[*] Keep this terminal open!"
echo "[*] Open a new terminal to connect via SSH"
echo ""
echo "SSH Connection Command:"
echo "    ssh root@127.0.0.1 -p 2222"
echo "    Password: alpine"
echo ""
echo "SCP File Transfer Example:"
echo "    scp -P 2222 file.txt root@127.0.0.1:/var/root/"
echo ""
echo "Press Ctrl+C to stop the proxy when done."
echo ""
echo "------------------------------------------"
echo ""

# Start iProxy - using port 2222 to avoid conflicts with system SSH
iproxy 2222 44
