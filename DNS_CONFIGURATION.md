# Entralinked DNS Configuration Enhancement

## Overview

The Entralinked project has been modified to allow users to specify a custom DNS address that the application broadcasts on, instead of relying solely on the local host address. This enhancement provides three methods for configuration:

1. **Command-line argument** (`--dns`)
2. **Configuration file** (`config.json`)
3. **Default behavior** (fallback to local host)

## Changes Made

### 1. Configuration.java
Added a new `dnsAddress` field to the `Configuration` record:

```java
public record Configuration(
        String hostName,
        String dnsAddress,  // NEW FIELD
        boolean clearPlayerDreamInfoOnWake,
        boolean allowOverwritingPlayerDreamInfo,
        boolean allowPlayerGameVersionMismatch,
        boolean allowWfcRegistrationThroughLogin) {
    
    public static final Configuration DEFAULT = new Configuration("local", null, true, false, false, true);
}
```

- **Type:** `String` (nullable)
- **Default:** `null` (falls back to `hostName` behavior)
- **Purpose:** Stores the custom DNS address to broadcast

### 2. CommandLineArguments.java
Extended the `CommandLineArguments` record to support the `--dns` flag:

```java
public record CommandLineArguments(boolean disableGui, String dnsAddress) {
    
    public CommandLineArguments(Collection<String> args) {
        this(args.contains("disablegui"), extractDnsAddress(args));
    }
    
    private static String extractDnsAddress(Collection<String> args) {
        List<String> argsList = new java.util.ArrayList<>(args);
        for(int i = 0; i < argsList.size(); i++) {
            if(argsList.get(i).equals("--dns") && i + 1 < argsList.size()) {
                return argsList.get(i + 1);
            }
        }
        return null;
    }
}
```

- **New field:** `dnsAddress` (String)
- **New method:** `extractDnsAddress()` - parses `--dns <address>` from command-line args
- **Returns:** The DNS address from CLI, or `null` if not provided

### 3. Entralinked.java
Refactored DNS address resolution logic:

**Before:**
- Only used `hostName` configuration to determine broadcast address

**After:**
1. **Parse CLI arguments** - Extract `--dns` flag if provided
2. **Override config** - If `--dns` is provided, override the `dnsAddress` in configuration
3. **Load configuration file** - Read `config.json` and apply CLI overrides
4. **Resolve DNS address** - Multi-step fallback logic:
   - If `configuration.dnsAddress()` is set → use it (with hostname resolution)
   - Else → fall back to `hostName` behavior (preserves original logic)
   - Else → use `NetworkUtility.getLocalHost()` (emergency fallback)

**Key code:**
```java
// Determine DNS address to broadcast
InetAddress dnsAddress = null;
String configuredDnsAddress = configuration.dnsAddress();

if(configuredDnsAddress != null && !configuredDnsAddress.isEmpty()) {
    try {
        dnsAddress = InetAddress.getByName(configuredDnsAddress);
        logger.info("Using custom DNS address from configuration: {}", configuredDnsAddress);
    } catch(UnknownHostException e) {
        logger.error("Could not resolve configured DNS address {} - falling back to local host", configuredDnsAddress, e);
        dnsAddress = null;
    }
}

// Fall back to host address if DNS address not configured
if(dnsAddress == null) {
    // ... use hostName configuration (original behavior)
}
```

## Usage

### Method 1: Command-Line Argument (Highest Priority)

Run with a custom DNS address:

```bash
java -jar entralinked.jar --dns 192.168.1.100
```

Or with GUI disabled:

```bash
java -jar entralinked.jar disablegui --dns 192.168.1.100
```

You can also use a hostname:

```bash
java -jar entralinked.jar --dns myserver.local
```

### Method 2: Configuration File

Edit `config.json` and add the `dnsAddress` field:

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

### Method 3: Default Behavior (Fallback)

If no `--dns` flag or `dnsAddress` in config.json:

- Entralinked uses the `hostName` configuration (default: `"local"`)
- Resolves to the local machine's IP address automatically

## Configuration Priority

1. **Command-line `--dns` flag** (highest priority)
2. **`config.json` `dnsAddress` field**
3. **`hostName` configuration** (original behavior, lowest priority)

## Error Handling

- If the specified DNS address cannot be resolved → logs warning and falls back to `hostName` behavior
- If all address resolution fails → application exits with fatal error
- Invalid hostnames are logged with descriptive messages

## Backward Compatibility

✅ **Fully backward compatible**

- Existing `config.json` files without `dnsAddress` field work unchanged
- Default configuration initializes `dnsAddress` as `null`
- Original `hostName`-based resolution still functions as fallback

## Example Scenarios

### Scenario 1: Server with Multiple Network Interfaces

```bash
java -jar entralinked.jar --dns 10.0.0.50
```
Forces the DNS server to broadcast on `10.0.0.50` instead of auto-detecting.

### Scenario 2: Persistent Configuration

**config.json:**
```json
{
  "hostName": "localhost",
  "dnsAddress": "192.168.0.99",
  "clearPlayerDreamInfoOnWake": true,
  "allowOverwritingPlayerDreamInfo": false,
  "allowPlayerGameVersionMismatch": false,
  "allowWfcRegistrationThroughLogin": true
}
```

### Scenario 3: Hostname Instead of IP

```bash
java -jar entralinked.jar --dns game-server.local
```

## Testing

After building with `./gradlew dist`, test the changes:

```bash
# Test with command-line DNS
java -jar build/libs/entralinked.jar --dns 127.0.0.1 disablegui

# Test without GUI
java -jar entralinked.jar disablegui --dns 192.168.1.100

# Test with config file (create config.json first)
java -jar entralinked.jar
```

Check the logs for confirmation messages like:
- `"Using custom DNS address from configuration: 192.168.1.100"`
- `"Configure your DS to use the following DNS server: 192.168.1.100"`
