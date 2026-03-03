# Entralinked DNS Configuration - Complete Usage Guide

## For End Users: Using the Settings Tab

### Quickest Way to Configure DNS

#### Option 1: Through GUI (Easiest) ✨

1. **Launch Entralinked** with GUI enabled (default)
   ```bash
   java -jar entralinked.jar
   ```

2. **Click "Settings" tab** at the top of the window
   ```
   [Console] [Dashboard] [Settings] ◄ Click here
   ```

3. **Enter your DNS address**
   - Enter IP: `192.168.1.100`
   - OR hostname: `game-server.local`
   - OR leave empty for auto-detection

4. **Click "Test Address"** (optional)
   - You'll see ✓ if valid or ✗ if invalid
   - Shows the resolved IP address

5. **Click "Save Settings"**
   - Confirmation dialog appears
   - DNS saved to config.json

6. **Restart the application**
   - Changes take effect after restart
   - Check Console tab for confirmation

**Status Messages You'll See:**
- ✓ Green: "Valid - Resolves to: 192.168.1.100"
- ✗ Red: "Invalid - Cannot resolve hostname"
- ⚫ Gray: "No custom DNS set - will use auto-detection"

---

#### Option 2: Through Config File

Create or edit `config.json` in the same directory as entralinked.jar:

```json
{
  "hostName": "local",
  "dnsAddress": "192.168.1.100",
  "clearPlayerDreamInfoOnWake": true,
  "allowOverwritingPlayerDreamInfo": false,
  "allowPlayerGameVersionMismatch": false,
  "allowWfcRegistrationThroughLogin": true
}
```

Restart the application.

---

#### Option 3: Command Line (Advanced)

```bash
java -jar entralinked.jar --dns 192.168.1.100
```

---

## Common Usage Scenarios

### Scenario 1: Multi-Network Setup

**Problem:** Your server has multiple network interfaces, need to use specific one

**Solution:**
1. Settings tab
2. Enter: `10.0.0.50`
3. Test Address → verify it shows ✓
4. Save Settings
5. Restart

**Result:** DS connects to 10.0.0.50

---

### Scenario 2: Using Hostname Instead of IP

**Problem:** Your network uses DNS names, not IPs

**Solution:**
1. Settings tab
2. Enter: `game-server.local`
3. Test Address → verify it resolves
4. Save Settings
5. Restart

**Result:** Hostname automatically resolves to IP at startup

---

### Scenario 3: Testing Different Networks

**Problem:** Need to test on multiple networks

**Solution:**
For each test:
1. Settings tab
2. Enter DNS address
3. Save Settings
4. Restart
5. Test with DS
6. Repeat for next network

---

### Scenario 4: Return to Auto-Detection

**Problem:** Set custom DNS but want to go back to auto-detect

**Solution:**
1. Settings tab
2. Click "Reset to Default"
3. Confirm dialog
4. Restart

**Result:** Returns to automatic local host detection

---

### Scenario 5: No GUI Available

**Problem:** Running without GUI (`disablegui` flag)

**Solution:**
Use command line:
```bash
java -jar entralinked.jar disablegui --dns 192.168.1.100
```

OR edit config.json directly.

---

## Troubleshooting

### Q: Settings won't save
**A:** Make sure DNS address is resolvable. Try Test Address first to verify.

### Q: Changes not taking effect
**A:** You must restart the application for changes to take effect.

### Q: GUI shows wrong DNS
**A:** Restart the application - GUI loads configuration from config.json at startup.

### Q: Can't find Settings tab
**A:** Make sure you're running with GUI (not using `disablegui` flag).

### Q: Reset button doesn't work
**A:** Check file permissions in working directory. config.json must be writable.

### Q: What if I want to use auto-detect?
**A:** Leave DNS Address field empty and save, OR click Reset to Default.

---

## What DNS Address Should I Use?

### My Computer (Local Testing)
```
127.0.0.1  (localhost)
OR
192.168.x.x (your computer's IP on local network)
```

### Server on Network
```
Server's IP address
OR
Server's hostname
```

### Multiple Network Interfaces
```
The specific IP of the interface you want to use
```

### Unsure?
```
Leave empty for auto-detection
(will use your computer's local network IP)
```

---

## Monitoring DNS Usage

### Check Console Tab
1. Open Entralinked with GUI
2. Click "Console" tab
3. Look for messages like:
   ```
   Using custom DNS address from configuration: 192.168.1.100
   Configure your DS to use the following DNS server: 192.168.1.100
   ```

### Check Logs
Look for these messages:
- "Using custom DNS address from configuration: X.X.X.X"
- "Configure your DS to use the following DNS server: X.X.X.X"

---

## Visual Walkthrough: Settings Tab

### Empty State (Auto-Detect)
```
┌────────────────────────────────────────┐
│ DNS Configuration                      │
│                                        │
│ DNS Address:                           │
│ [                               ]      │
│ ⚫ No custom DNS set - will use       │
│   auto-detection                       │
│                                        │
│ [Test Address]                         │
│                                        │
│          [Save] [Reset]                │
└────────────────────────────────────────┘
```

### After Entering Valid IP
```
┌────────────────────────────────────────┐
│ DNS Configuration                      │
│                                        │
│ DNS Address:                           │
│ [192.168.1.100                    ]    │
│ ✓ Valid - Resolves to: 192.168.1.100 │
│                                        │
│ [Test Address]                         │
│                                        │
│          [Save] [Reset]                │
└────────────────────────────────────────┘
```

### After Saving
```
Dialog appears:
"Settings saved successfully!

Note: DNS changes will take effect on
the next restart."
```

---

## Configuration File Location

**Where:** `config.json` in the same directory as `entralinked.jar`

**What it looks like:**
```json
{
  "hostName" : "local",
  "dnsAddress" : "192.168.1.100",
  "clearPlayerDreamInfoOnWake" : true,
  "allowOverwritingPlayerDreamInfo" : false,
  "allowPlayerGameVersionMismatch" : false,
  "allowWfcRegistrationThroughLogin" : true
}
```

**Key points:**
- `dnsAddress`: Your custom DNS (or null for auto-detect)
- `hostName`: Fallback if no dnsAddress set
- Can edit manually or use Settings GUI tab

---

## Quick Reference Card

| Task | Method | Steps |
|------|--------|-------|
| Set custom DNS | GUI Settings | Enter → Test → Save → Restart |
| Use hostname | GUI Settings | Enter hostname → Test → Save → Restart |
| CLI flag | Command line | `--dns 192.168.1.100` |
| Edit config | Text editor | Edit config.json → Restart |
| Reset to default | GUI Settings | Click Reset → Confirm → Restart |
| Check current DNS | Console | Look for "Configure your DS to use..." |
| Auto-detect (no custom) | Leave empty | Empty field in Settings → Save |

---

## Summary

### GUI Settings Tab Makes It Easy ✨

✅ No command line needed  
✅ Real-time validation  
✅ Visual feedback (✓ or ✗)  
✅ One-click reset  
✅ Persistent configuration  
✅ Clear status messages  

### Three Ways to Configure

1. **GUI Settings Tab** (easiest)
2. **config.json** (persistent)
3. **CLI --dns flag** (one-time)

### Remember

⚠️ Changes take effect after **restart**  
✓ Settings are saved to config.json  
✓ Empty field = auto-detect (original behavior)  

---

**Need help? Check the DNS in the Console tab after restart!**

