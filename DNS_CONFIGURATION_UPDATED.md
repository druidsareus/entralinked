# DNS Configuration

Entralinked's DNS configuration has been enhanced to support custom DNS address specification. This allows precise control over which address is advertised to your DS system.

## Methods

DNS configuration can be set using any of the following methods:

### GUI Settings Tab (Recommended)

The graphical interface provides the easiest method for configuration:

1. Click the **Settings** tab in the main window
2. Enter your DNS address in the input field
3. Click **Test Address** to validate
4. Click **Save Settings**
5. Restart Entralinked

See [SETTINGS_TAB.md](SETTINGS_TAB.md) for detailed instructions.

### Configuration File

Edit `config.json` in the application's working directory:

```json
{
  "dnsAddress": "192.168.1.100"
}
```

Restart Entralinked for changes to take effect.

### Command-Line Argument

Specify DNS at runtime:

```
java -jar entralinked.jar --dns 192.168.1.100
```

The `--dns` flag takes priority over configuration file settings.

## Configuration Priority

DNS configuration is resolved in this order:

1. `--dns` command-line flag (highest priority)
2. `dnsAddress` in `config.json`
3. `hostName` in `config.json`
4. Automatic local host detection (default)

## Supported Address Formats

- **IPv4 address:** `192.168.1.100`
- **Hostname:** `game-server.local` or `localhost`
- **Empty/Not specified:** Automatic local network detection

## Validation

The application validates DNS addresses during startup and when using the Settings tab. Invalid or unresolvable addresses will trigger a warning and fallback to the next priority option.

When using the Settings tab, invalid addresses are rejected before saving.

## Verification

To verify your DNS configuration is active:

1. Launch Entralinked
2. Check the Console tab or application logs
3. Look for the message: `Configure your DS to use the following DNS server: X.X.X.X`
4. Configure your DS to use the displayed address

## Examples

### Single Network Interface

```bash
java -jar entralinked.jar --dns 192.168.1.100
```

### Multiple Network Interfaces

Edit `config.json`:

```json
{
  "dnsAddress": "10.0.0.50"
}
```

### Using Hostname Resolution

```bash
java -jar entralinked.jar --dns game-server.local
```

The hostname will be resolved to an IP address at startup.

### Default Behavior

If no DNS configuration is specified, Entralinked will automatically detect and use your local network address.

## Backward Compatibility

This feature is fully backward compatible. Existing configurations without the `dnsAddress` field will continue to work as before, automatically detecting the local host address.
