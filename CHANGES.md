# Summary: Entralinked DNS Configuration Feature

## Modified Files

The following source files have been modified to add DNS configuration support:

### 1. **Configuration.java**
- **Added field:** `String dnsAddress` (nullable)
- **Updated DEFAULT:** `new Configuration("local", null, true, false, false, true)`
- **Purpose:** Allows storing a custom DNS broadcast address in `config.json`

### 2. **CommandLineArguments.java**
- **Added field:** `String dnsAddress` (nullable)
- **Added method:** `extractDnsAddress(Collection<String> args)` - parses `--dns <address>` flag
- **Purpose:** Supports command-line argument `--dns <address>` for runtime DNS configuration

### 3. **Entralinked.java**
- **Refactored DNS address resolution** with three-tier priority system
- **Updated logic:** 
  - CLI `--dns` flag → Config override → Fallback to `hostName` config
  - Better error handling and logging
  - Maintains backward compatibility

### 4. **DNS_CONFIGURATION.md** (NEW)
- Comprehensive documentation of all changes
- Usage examples for all configuration methods
- Error handling and priority documentation

## Key Features

✅ **Three configuration methods:**
1. Command-line: `java -jar entralinked.jar --dns 192.168.1.100`
2. Config file: Add `"dnsAddress": "192.168.1.100"` to `config.json`
3. Default: Falls back to `hostName` configuration

✅ **Backward compatible** - existing projects work unchanged

✅ **Hostname support** - can use domain names like `server.local`

✅ **Error handling** - graceful fallback with descriptive logging

✅ **Full priority system** - CLI > Config File > Default behavior

## How to Use

### Build the project:
```bash
cd entralinked
./gradlew dist
```

### Run with custom DNS:
```bash
java -jar build/libs/entralinked.jar --dns 192.168.1.100

# Or with GUI disabled:
java -jar entralinked.jar disablegui --dns 10.0.0.50

# Or with hostname:
java -jar entralinked.jar --dns game-server.local
```

### Or configure in config.json:
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

## Files Changed

```
Modified: src/main/java/entralinked/Configuration.java
Modified: src/main/java/entralinked/CommandLineArguments.java
Modified: src/main/java/entralinked/Entralinked.java
Created:  DNS_CONFIGURATION.md
```

## Next Steps

1. Rebuild the project: `./gradlew dist`
2. Test the new DNS functionality with command-line arguments
3. Test with `config.json` configuration
4. Verify DS can connect using the specified DNS address
