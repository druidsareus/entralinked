# DNS Configuration Settings Tab

Entralinked's DNS configuration can now be managed directly through the GUI. The new Settings tab provides an intuitive interface for specifying custom DNS addresses without requiring command-line knowledge or manual config editing.

## Features

The Settings tab includes the following functionality:

- **DNS Address Input:** Configure a custom DNS address (IPv4 or hostname) that the application will broadcast on
- **Validation:** Real-time hostname resolution with visual feedback (✓ valid in green, ✗ invalid in red)
- **Save:** Persist DNS configuration to `config.json`
- **Reset:** Revert to auto-detection with a single click
- **Status Display:** Clear indication of the current DNS configuration state

## Usage

### Accessing Settings

1. Launch Entralinked with GUI enabled (default behavior)
2. Click the **Settings** tab in the main window
3. Navigate to the DNS Configuration section

### Configuring Custom DNS

1. Enter your desired DNS address in the input field:
   - IPv4 address (e.g., `192.168.1.100`)
   - Hostname (e.g., `game-server.local`)
   - Leave empty for auto-detection

2. Click **Test Address** to validate your entry:
   - Green checkmark (✓) indicates valid address
   - Red X (✗) indicates invalid or unresolvable address

3. Click **Save Settings** to persist the configuration to `config.json`

4. Restart Entralinked for changes to take effect

### Resetting to Defaults

1. Click **Reset to Default** button
2. Confirm the action in the dialog
3. Restart Entralinked to revert to auto-detection

## Configuration Priority

DNS configuration is resolved in the following order:

1. Command-line `--dns` flag (highest priority)
2. `dnsAddress` field in `config.json`
3. `hostName` field in `config.json`
4. Automatic local host detection (lowest priority)

## Configuration File

Settings are persisted to `config.json` in the application's working directory. Manual editing is possible:

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

The `dnsAddress` field is optional. Omitting it or setting it to `null` will fall back to auto-detection based on the `hostName` setting.

## Validation

The Settings tab validates DNS addresses using Java's `InetAddress.getByName()` method. This supports:

- IPv4 addresses
- Fully qualified domain names
- Short hostnames resolvable through your system's DNS

Invalid or unresolvable addresses will be rejected with an error dialog and will not be saved.

## Notes

- DNS configuration changes require an application restart to take effect
- The current DNS address is displayed in the Console tab upon startup
- Empty DNS field defaults to auto-detection of your local network address
- This feature is fully backward compatible with existing configurations
