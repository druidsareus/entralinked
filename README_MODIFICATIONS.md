# Entralinked - DNS Configuration Enhancement

## Overview

This modified version of Entralinked adds support for custom DNS address configuration, allowing you to specify exactly which DNS address the application broadcasts on.

## What's New

🆕 **Three ways to configure DNS:**

1. **Command-line argument** (highest priority):
   ```bash
   java -jar entralinked.jar --dns 192.168.1.100
   ```

2. **Configuration file** (`config.json`):
   ```json
   {
     "dnsAddress": "192.168.1.100"
   }
   ```

3. **Default behavior** (falls back to `hostName` setting):
   - Automatically uses local host IP if no DNS specified

## Quick Start

### Build:
```bash
./gradlew dist
```

### Run with custom DNS:
```bash
# With IP address
java -jar build/libs/entralinked.jar --dns 192.168.1.100

# With hostname
java -jar build/libs/entralinked.jar --dns game-server.local

# GUI disabled
java -jar entralinked.jar disablegui --dns 10.0.0.50
```

## Modified Files

| File | Changes |
|------|---------|
| `Configuration.java` | Added `dnsAddress` field |
| `CommandLineArguments.java` | Added `--dns` flag parsing |
| `Entralinked.java` | Updated DNS resolution logic |

## Documentation Files

- **DNS_CONFIGURATION.md** - Comprehensive feature documentation
- **CHANGES.md** - Summary of modifications
- **MODIFICATIONS_DETAIL.txt** - Detailed before/after code comparison
- **README_MODIFICATIONS.md** - This file

## Key Features

✅ Backward compatible - existing projects work unchanged  
✅ Hostname support - use domain names like `server.local`  
✅ Priority system - CLI overrides config file, falls back to default  
✅ Error handling - graceful fallback with detailed logging  
✅ No breaking changes - all existing functionality preserved

## Use Cases

### Multi-NIC Server
Use specific network interface for DNS:
```bash
java -jar entralinked.jar --dns 10.0.0.50
```

### Persistent Configuration
Store DNS address in `config.json` for production deployments

### Network Testing
Easily switch DNS addresses without code changes:
```bash
java -jar entralinked.jar --dns 192.168.1.100  # Test network 1
java -jar entralinked.jar --dns 192.168.2.100  # Test network 2
```

## Testing

Test command-line override:
```bash
java -jar build/libs/entralinked.jar --dns 127.0.0.1 disablegui
```

Check logs for:
```
Using custom DNS address from configuration: 127.0.0.1
Configure your DS to use the following DNS server: 127.0.0.1
```

## Configuration Priority

1. `--dns` command-line flag (highest)
2. `dnsAddress` in `config.json`
3. `hostName` in `config.json` (original behavior)
4. Auto-detected local host (lowest, fallback)

## Example Configurations

### CLI Only (No Config File Needed)
```bash
java -jar entralinked.jar --dns 192.168.1.100
```

### Persistent Config
**config.json:**
```json
{
  "hostName": "localhost",
  "dnsAddress": "192.168.1.100",
  "clearPlayerDreamInfoOnWake": true,
  "allowOverwritingPlayerDreamInfo": false,
  "allowPlayerGameVersionMismatch": false,
  "allowWfcRegistrationThroughLogin": true
}
```

### DNS Hostname
**config.json:**
```json
{
  "dnsAddress": "game-server.local"
}
```

## Backward Compatibility

✅ 100% backward compatible

- Old `config.json` files work unchanged (dnsAddress defaults to null)
- Existing command-line usage unchanged
- Default behavior identical to original if DNS not specified

## Troubleshooting

**"Could not resolve configured DNS address":**
- Check that the address is reachable
- Verify hostname spelling
- Ensure network connectivity

**DS still can't connect:**
- Check logs for the reported DNS address
- Verify DS networking settings point to this address
- Ensure no firewall blocking port 53 (DNS)

---

For detailed documentation, see **DNS_CONFIGURATION.md**
