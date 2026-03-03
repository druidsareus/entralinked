# GUI Enhancement: DNS Configuration Panel

## Overview

The Entralinked GUI has been enhanced with a new **Settings tab** that allows users to configure custom DNS addresses directly through the user interface. No command-line knowledge required!

## New Features

### Settings Tab

A new tab has been added to the main window with DNS configuration options.

**Location:** `GUI Window → Settings Tab`

#### DNS Configuration Section

The Settings panel includes:

1. **DNS Address Input Field**
   - Text field for entering custom DNS address
   - Supports IPv4 addresses: `192.168.1.100`
   - Supports hostnames: `game-server.local`
   - Optional field (leave empty for auto-detection)

2. **Test Address Button**
   - Validates the entered DNS address
   - Attempts hostname resolution
   - Shows result with visual feedback:
     - ✓ Green: Valid and resolvable
     - ✗ Red: Invalid or cannot resolve
     - Gray: Default/no custom DNS

3. **Save Settings Button**
   - Saves DNS configuration to `config.json`
   - Validates address before saving
   - Confirms successful save
   - Notifies user that restart is required

4. **Reset to Default Button**
   - Clears custom DNS configuration
   - Reverts to auto-detection behavior
   - Requires confirmation
   - Saves changes to `config.json`

## Files Modified

### 1. SettingsPanel.java (NEW FILE)
- **Location:** `src/main/java/entralinked/gui/panels/SettingsPanel.java`
- **Size:** 8.9 KB
- **Purpose:** DNS configuration UI panel
- **Features:**
  - DNS input field with placeholder
  - Real-time address validation
  - Save/Reset functionality
  - Configuration persistence to `config.json`

### 2. MainView.java
- **Modified:** Added Settings tab to tabbed pane
- **Change:** One line added to initialize SettingsPanel
- **Impact:** Users see Settings tab in main window

## How to Use

### Step 1: Open Settings Tab
1. Launch Entralinked with GUI
2. Click the **"Settings"** tab in the main window

### Step 2: Enter DNS Address
1. Click the **DNS Address** input field
2. Enter one of:
   - IPv4 address: `192.168.1.100`
   - Hostname: `game-server.local`
   - Leave empty for auto-detection

### Step 3: Test (Optional)
1. Click **"Test Address"** button
2. Look for status message:
   - ✓ Valid address (green)
   - ✗ Invalid address (red)
   - No DNS set (gray)

### Step 4: Save
1. Click **"Save Settings"** button
2. Confirm successful save dialog
3. **Restart application** for changes to take effect

## Usage Examples

### Example 1: Specific Network Interface
**Scenario:** Server with multiple network interfaces

1. Settings → DNS Address field
2. Enter: `10.0.0.50`
3. Test Address → Verify it resolves
4. Save Settings → Confirm
5. Restart application

### Example 2: Using Hostname
**Scenario:** Network uses DNS hostname

1. Settings → DNS Address field
2. Enter: `game-server.local`
3. Test Address → Verify hostname resolution
4. Save Settings → Confirm
5. Restart application

### Example 3: Reset to Auto-Detect
**Scenario:** Want to return to auto-detection

1. Settings → Clear DNS Address field (or use Reset button)
2. Click **"Reset to Default"** button
3. Confirm dialog
4. Restart application

## Configuration Flow

```
User Input (GUI)
    ↓
Test Address (optional)
    ↓
Save Settings Button
    ↓
Validation (hostname resolution)
    ↓
Write to config.json
    ↓
Display success/error dialog
    ↓
Requires restart to take effect
```

## Technical Details

### SettingsPanel Class

**Package:** `entralinked.gui.panels`

**Constructor:**
```java
public SettingsPanel(Entralinked entralinked)
```

**Key Methods:**
- `createDnsConfigPanel()` - Creates DNS configuration section
- `testDnsAddress()` - Validates and resolves DNS address
- `updateFieldsFromConfig()` - Loads current configuration
- `saveSettings()` - Saves to config.json with validation
- `resetToDefault()` - Resets to auto-detection

**Imports:**
- Swing components (JPanel, JTextField, JButton, etc.)
- FlatLaf components (FlatTextField)
- Jackson ObjectMapper (JSON serialization)
- InetAddress (hostname resolution)
- Configuration model

### Integration Points

1. **MainView.java**
   - Adds SettingsPanel tab to main window
   - Passes Entralinked instance to panel

2. **Configuration.java**
   - Reads `dnsAddress` field from config.json
   - SettingsPanel updates this field

3. **Entralinked.java**
   - SettingsPanel calls `getConfiguration()` method
   - Configuration is used at startup

## Error Handling

### Validation Errors
- **Invalid Hostname:** Shows error dialog with hostname
- **Failed to Save:** Shows exception details
- **File I/O Error:** Displays error dialog

### User Feedback
- **Status Label** shows real-time validation result
- **Color Coding:**
  - 🟢 Green: Valid/Success
  - 🔴 Red: Error/Invalid
  - ⚫ Gray: Not set/Default

## Important Notes

⚠️ **Restart Required**
- DNS changes only take effect after application restart
- User is notified via dialog message
- Console output will show which DNS is being used

✅ **Backward Compatible**
- Existing configs without dnsAddress field work unchanged
- Empty field = auto-detection (original behavior)
- No breaking changes

## Testing

### Test Case 1: Valid IP Address
```
Input: 192.168.1.100
Expected: ✓ Valid - Resolves to: 192.168.1.100
Action: Save → Restart → Verify in logs
```

### Test Case 2: Valid Hostname
```
Input: localhost
Expected: ✓ Valid - Resolves to: 127.0.0.1
Action: Save → Restart → Verify in logs
```

### Test Case 3: Invalid Address
```
Input: invalid.nonsense.domain
Expected: ✗ Invalid - Cannot resolve hostname
Action: Cannot save (validation error)
```

### Test Case 4: Empty Field
```
Input: (empty)
Expected: No custom DNS set - will use auto-detection
Action: Save → Restart → Uses auto-detection
```

### Test Case 5: Reset Button
```
Action: Click Reset → Confirm → Verify field is empty
Expected: dnsAddress removed from config.json
Restart: Uses auto-detection
```

## Screenshots Description

The Settings tab includes:

1. **DNS Configuration Section**
   - Titled border: "DNS Configuration"
   - Description text explaining usage
   - Input field with placeholder
   - Status label with validation feedback

2. **Buttons**
   - Test Address (inline)
   - Save Settings (footer)
   - Reset to Default (footer)

3. **Status Display**
   - Real-time validation status
   - Color-coded messages
   - Shows resolved IP address

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Changes not taking effect | Restart the application |
| DNS field shows old value | Reload config.json or restart |
| "Cannot resolve hostname" error | Check hostname spelling, verify network |
| Save button does nothing | Check if hostname is resolvable first |
| Config.json not updating | Check file permissions in working directory |

## Future Enhancements

Possible additions in future versions:
- Live DNS change without restart (advanced)
- DNS preset profiles
- Network interface selection UI
- Connection test to DS
- DNS query logging in console

## Summary

The new Settings panel provides an easy, user-friendly way to configure custom DNS addresses without command-line knowledge. Users can:

✅ Set custom DNS addresses through GUI  
✅ Test addresses before saving  
✅ Persist configuration to config.json  
✅ Reset to default with one click  
✅ See visual feedback on validity  

All while maintaining full backward compatibility and clarity about when changes take effect.
