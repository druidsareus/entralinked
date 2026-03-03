# Implementation Guide

This guide documents the DNS configuration enhancements made to Entralinked.

## Overview

Two features have been added:

1. **Command-line DNS flag** - Specify DNS at runtime with `--dns`
2. **GUI Settings tab** - Configure DNS through the graphical interface

Both features integrate seamlessly with the existing configuration system while maintaining full backward compatibility.

## Files Modified

### Source Code

#### Configuration.java

Added field:
```java
String dnsAddress
```

The `dnsAddress` field stores the custom DNS address. It is optional and defaults to `null`, which triggers automatic local host detection.

#### CommandLineArguments.java

Added field and parsing:
```java
String dnsAddress
```

The `--dns <address>` command-line argument is parsed and passed to the configuration system. This takes priority over configuration file settings.

#### Entralinked.java

Refactored DNS address resolution:

1. Parse command-line arguments
2. Load configuration file
3. Apply CLI override if `--dns` specified
4. Resolve DNS address using three-tier priority
5. Initialize DNS server with resolved address

#### MainView.java

Added Settings tab to main window tabbed pane. One line modification.

#### SettingsPanel.java (NEW)

Complete DNS configuration UI component. Features include:

- DNS address input field
- Test validation button
- Save and Reset buttons
- Real-time status display
- Error handling with user dialogs
- Configuration persistence to `config.json`

### Documentation

See [SETTINGS_TAB.md](SETTINGS_TAB.md) and [DNS_CONFIGURATION_UPDATED.md](DNS_CONFIGURATION_UPDATED.md).

## Configuration Priority

DNS configuration is resolved in the following order:

1. `--dns` command-line flag
2. `dnsAddress` field in `config.json`
3. `hostName` field in `config.json`
4. Automatic local host detection

## Building

```
./gradlew dist
```

## Testing

### Test Case 1: Command-Line DNS

```bash
java -jar entralinked.jar --dns 192.168.1.100 disablegui
```

Expected: Application uses specified DNS address.

### Test Case 2: Configuration File DNS

Create `config.json`:
```json
{
  "dnsAddress": "192.168.1.100"
}
```

Expected: Application loads and uses DNS from config file.

### Test Case 3: CLI Override

With `config.json` containing `"dnsAddress": "10.0.0.1"`, run:

```bash
java -jar entralinked.jar --dns 192.168.1.100
```

Expected: CLI flag takes priority. Application uses `192.168.1.100`.

### Test Case 4: GUI Settings Tab

1. Launch with GUI
2. Click Settings tab
3. Enter DNS address
4. Click Test Address
5. Click Save Settings
6. Restart application

Expected: Configuration saved to `config.json`. Application uses specified DNS.

### Test Case 5: Hostname Resolution

```bash
java -jar entralinked.jar --dns localhost
```

Expected: Hostname resolved to IP address. Application uses resolved address.

## Backward Compatibility

All existing configurations continue to function without modification:

- `config.json` files without `dnsAddress` field work unchanged
- Command-line usage without `--dns` flag works unchanged
- Default behavior (auto-detection) preserved as fallback

## Implementation Details

### Validation

DNS addresses are validated using `java.net.InetAddress.getByName()`. This supports:

- IPv4 addresses
- Fully qualified domain names
- Short hostnames resolvable through system DNS

Invalid addresses trigger fallback behavior or error messages depending on context.

### Persistence

The Settings tab writes configuration to `config.json` using Jackson's ObjectMapper with pretty-printing enabled. The file is only written when the user explicitly clicks "Save Settings".

### Error Handling

- Invalid command-line DNS triggers a warning and fallback
- Invalid Settings tab input prevents saving with error dialog
- File I/O errors display user-friendly error messages
- All fallback mechanisms ensure the application continues functioning

## Architecture

```
User Input (CLI/GUI/Config File)
    ↓
CommandLineArguments / Configuration loaded
    ↓
Three-tier Priority Resolution
    ↓
InetAddress Validation
    ↓
DnsServer initialized with resolved address
    ↓
Broadcast to DS system
```

## Console Output

Upon startup, the application logs the configured DNS:

```
Configure your DS to use the following DNS server: 192.168.1.100
```

This message appears in the Console tab and confirms which DNS address is active.

## Future Enhancements

Potential improvements for future versions:

- Live DNS switching without restart
- DNS preset profiles
- Network interface selection UI
- Detailed DNS logging and statistics
- Configuration import/export functionality
