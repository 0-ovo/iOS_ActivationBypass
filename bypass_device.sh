#!/bin/bash
# iOS Activation Bypass Script
# Run this on the jailbroken device via SSH

echo "=================================="
echo "iOS Activation Bypass Script"
echo "=================================="
echo ""

echo "[1/4] Mounting filesystem as read-write..."
mount -o rw,union,update /
if [ $? -eq 0 ]; then
    echo "✓ Filesystem mounted successfully"
else
    echo "✗ Failed to mount filesystem"
    exit 1
fi

echo ""
echo "[2/4] Unloading mobileactivationd..."
launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist
if [ $? -eq 0 ]; then
    echo "✓ mobileactivationd unloaded"
else
    echo "✗ Failed to unload mobileactivationd"
    exit 1
fi

echo ""
echo "[3/4] Removing original mobileactivationd..."
rm /usr/libexec/mobileactivationd
if [ $? -eq 0 ]; then
    echo "✓ Original mobileactivationd removed"
else
    echo "✗ Failed to remove mobileactivationd"
    exit 1
fi

echo ""
echo "[4/4] Updating UI cache..."
uicache --all
if [ $? -eq 0 ]; then
    echo "✓ UI cache updated"
else
    echo "✗ Failed to update UI cache"
    exit 1
fi

echo ""
echo "=================================="
echo "Phase 1 Complete!"
echo "=================================="
echo ""
echo "NEXT STEPS:"
echo "1. Use WinSCP to transfer 'mobileactivationd' to /usr/libexec/"
echo "2. Run the finalize script: ./finalize_bypass.sh"
echo ""
