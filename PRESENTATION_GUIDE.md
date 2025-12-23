# iOS Activation Bypass - Presentation Quick Guide

> **Fast Reference for Live Demonstrations**

---

## Pre-Demo Checklist

### Hardware
- [ ] A7 device (iPhone 5s/6/6+, iPad Air, iPad Mini 2/3)
- [ ] Computer (Windows, Linux, or macOS)
- [ ] USB cable
- [ ] Internet connection (for downloads if needed)

### Software Downloads (Prepare Before Demo)

**All Platforms:**
- [ ] [Checkra1n 0.10.2](https://checkra.in/releases/0.10.2-beta#all-downloads)

**Linux/macOS:**
- [ ] libimobiledevice (`sudo apt install libusbmuxd-tools libimobiledevice-utils`)
- [ ] Optional: sshpass (`sudo apt install sshpass`) for automated transfers

**Windows:**
- [ ] [libimobiledevice v1.3.17](https://github.com/libimobiledevice-win32/imobiledevice-net/releases/download/v1.3.17/libimobiledevice.1.2.1-r1122-win-x64.zip) (already in repo)
- [ ] [WinSCP](https://winscp.net/)

### Files Ready
- [ ] `mobileactivationd` (in repo)
- [ ] `bypass_device.sh` (in repo)
- [ ] `finalize_bypass.sh` (in repo)
- [ ] `setup_proxy.ps1` (in repo)

---

## Demo Flow - 5 Minutes

### Part 1: Jailbreak (2 min)
```
┌─────────────────────────────────────┐
│  1. Connect device via USB          │
│  2. Run Checkra1n 0.10.2            │
│  3. Follow prompts to DFU mode      │
│  4. Wait for "All Done"             │
└─────────────────────────────────────┘
```

**Key Talking Points:**
- Checkra1n uses bootrom exploit (unpatchable)
- Works on A7-A11 devices
- Tethered jailbreak (reboot requires re-jailbreak)

**If "Right Before Trigger" Freeze:**
- Calmly explain this is known behavior
- Unplug after 15-20 seconds
- Wait 2 seconds, plug back in
- Should see "Booting Up" immediately

---

### Part 2: Setup Connection (1 min)

Choose your platform:

---

#### **Linux/macOS Demo Flow**

**Terminal 1 - Start Proxy:**
```bash
./setup_proxy.sh
```
*Leave this terminal open!*

**Terminal 2 - Connect via SSH:**
```bash
ssh root@127.0.0.1 -p 2222
# Password: alpine
```

**Key Talking Points:**
- iProxy tunnels SSH over USB (no network needed)
- Default Checkra1n SSH port is 44
- We're using local port 2222 to avoid conflicts
- Default root password is "alpine"

---

#### **Windows Demo Flow**

**Window 1 - Start Proxy:**
```powershell
cd [extracted-libimobiledevice-folder]
.\setup_proxy.ps1
```
*Leave this window open!*

**Window 2 - Connect via SSH:**
```powershell
ssh root@127.0.0.1
# Password: alpine
```

**WinSCP Connection:**
- Host: `127.0.0.1`
- User: `root`
- Password: `alpine`
- Protocol: SCP

---

### Part 3: Execute Bypass (2 min)

**On Device:**
Navigate to WiFi screen (don't connect)

---

#### **Linux/macOS Execution**

**Terminal 2** (already in SSH):
```bash
# Let automated script handle file transfer
exit
```

**Terminal 2** (back on host):
```bash
# Transfer scripts automatically
./transfer_files.sh

# SSH back in
ssh root@127.0.0.1 -p 2222
cd /var/root
./bypass_device.sh
```

**Script Output:**
```
==================================
[1/4] Mounting filesystem...      ✓
[2/4] Unloading mobileactivationd ✓
[3/4] Removing original file...   ✓
[4/4] Updating UI cache...        ✓
==================================
Phase 1 Complete!
```

**Terminal 3** (new terminal on host):
```bash
./transfer_patch.sh
```

**Back in Terminal 2** (SSH session):
```bash
./finalize_bypass.sh
```

**Script Output:**
```
==================================
[1/2] Setting permissions...      ✓
[2/2] Loading daemon...           ✓
==================================
✓ BYPASS COMPLETE!
```

**On Device:**
Tap "Connect to iTunes" → Bypass complete!

---

#### **Windows Execution**

**In WinSCP:**
1. Transfer `bypass_device.sh` to `/var/root/`
2. Transfer `finalize_bypass.sh` to `/var/root/`

**In SSH Window:**
```bash
cd /var/root
chmod +x bypass_device.sh finalize_bypass.sh
./bypass_device.sh
```

**Script Output:**
```
==================================
[1/4] Mounting filesystem...      ✓
[2/4] Unloading mobileactivationd ✓
[3/4] Removing original file...   ✓
[4/4] Updating UI cache...        ✓
==================================
Phase 1 Complete!
```

**In WinSCP:**
Transfer `mobileactivationd` to `/usr/libexec/mobileactivationd`

**In SSH Window:**
```bash
./finalize_bypass.sh
```

**Script Output:**
```
==================================
[1/2] Setting permissions...      ✓
[2/2] Loading daemon...           ✓
==================================
✓ BYPASS COMPLETE!
```

**On Device:**
Tap "Connect to iTunes" → Bypass complete!

**Key Talking Points:**
- Scripts automate manual process
- Error checking at each step
- Patched daemon bypasses activation check
- Device fully functional after bypass

---

## Presentation Tips

### Opening (30 seconds)
"Today I'm demonstrating an iOS activation bypass for older A7 devices. This technique uses the Checkra1n jailbreak combined with a patched activation daemon to bypass iCloud activation lock on devices like iPhone 5s, 6, and iPad Air."

### During Jailbreak (while waiting)
- Explain bootrom exploits vs userland
- Discuss why A7 devices are vulnerable
- Mention the Checkm8 exploit

### During File Transfer
- Explain what mobileactivationd does
- Discuss how the patch works
- Cover limitations (tethered, iOS 12.5.x only)

### Closing (30 seconds)
"As you can see, with the automated scripts this process is straightforward and takes about 5 minutes. The device is now fully functional, bypassing the activation lock. This is for educational purposes and should only be used on devices you own."

---

## Common Demo Issues

### Checkra1n Hangs
**What to say:** "This is a known issue with the exploit. Watch how we handle it..."
**Do:** Unplug → wait → replug

### SSH Won't Connect
**Check:** Is iProxy running?
**Try:** Restart iProxy, reconnect USB

### Scripts Fail
**Fallback:** Have manual commands ready in README.md
**What to say:** "Let me show you the manual process the scripts automate..."

---

## Audience Q&A Prep

**Q: Is this legal?**
A: It's legal on devices you own. Using on stolen devices is illegal.

**Q: Does this work on newer iPhones?**
A: No, only A7 devices (iPhone 5s through 6 Plus era). Newer devices patched the bootrom exploit.

**Q: Can Apple patch this?**
A: No, the Checkm8 exploit is in the bootrom (hardware). Cannot be patched via software updates.

**Q: What are the limitations?**
A: Tethered jailbreak (must re-jailbreak after reboot), iOS 12.5.x only, some services may not work.

**Q: Could someone use this on my lost iPhone?**
A: Activation Lock still prevents this on modern devices. This only works on specific older models.

---

## One-Page Cheat Sheet

### Linux/macOS Quick Reference
```
DEMO STEPS - LINUX/MACOS
=========================

1. JAILBREAK
   └─> Checkra1n → DFU → Wait

2. CONNECT
   ├─> Terminal 1: ./setup_proxy.sh (keep running)
   └─> Terminal 2: ssh root@127.0.0.1 -p 2222 (alpine)

3. BYPASS
   ├─> Device: Navigate to WiFi screen
   ├─> Terminal 2: exit (back to host)
   ├─> Terminal 2: ./transfer_files.sh
   ├─> Terminal 2: ssh root@127.0.0.1 -p 2222
   ├─> Terminal 2 (SSH): cd /var/root && ./bypass_device.sh
   ├─> Terminal 3: ./transfer_patch.sh
   ├─> Terminal 2 (SSH): ./finalize_bypass.sh
   └─> Device: Tap "Connect to iTunes"

DONE!
```

### Windows Quick Reference
```
DEMO STEPS - WINDOWS
=====================

1. JAILBREAK
   └─> Checkra1n → DFU → Wait

2. CONNECT
   ├─> PowerShell 1: .\setup_proxy.ps1
   ├─> PowerShell 2: ssh root@127.0.0.1 (alpine)
   └─> WinSCP: 127.0.0.1, root, alpine

3. BYPASS
   ├─> Device: Navigate to WiFi screen
   ├─> WinSCP: Transfer bypass_device.sh & finalize_bypass.sh
   ├─> SSH: chmod +x *.sh && ./bypass_device.sh
   ├─> WinSCP: Transfer mobileactivationd → /usr/libexec/
   ├─> SSH: ./finalize_bypass.sh
   └─> Device: Tap "Connect to iTunes"

DONE!
```

---

## Time-Saving Demo Hacks

### Pre-Demo Preparation
1. **Have device already jailbroken** (if demo time is tight)
2. **Keep iProxy running** before presentation starts
3. **Open WinSCP and SSH windows** beforehand
4. **Test run** entire process day before

### For Multiple Demos
1. **Keep device in jailbroken state** between demos
2. **Only show bypass portion** (most impressive part)
3. **Use pre-recorded video** of jailbreak process

### Backup Plans
1. **Record entire process** beforehand in case of failure
2. **Have screenshot gallery** of each step
3. **Print this guide** for quick reference

---

## Script Talking Track

*[Connect device]*
"First, we'll jailbreak the device using Checkra1n, which exploits a hardware vulnerability in the A7 chip."

*[Run Checkra1n]*
"The jailbreak process puts the device into DFU mode and loads a custom boot chain."

*[Setup proxy]*
"Now we'll use iProxy to create an SSH tunnel over USB - no network required."

*[Connect SSH]*
"Default Checkra1n credentials are root/alpine. We're now inside the iOS filesystem."

*[Run scripts]*
"I've created automation scripts that handle all the commands. Watch the progress..."

*[Transfer file]*
"We're replacing the legitimate activation daemon with a patched version that always returns 'activated'."

*[Finalize]*
"Setting proper permissions and reloading the daemon..."

*[Complete]*
"And just like that, activation lock is bypassed. The device is now fully functional."

---

**Good luck with your presentation!**
