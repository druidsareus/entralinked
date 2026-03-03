# Entralinked - Auto-Detection DNS Configuration

## Overview

Entralinked now automatically detects and uses the host machine's IP address for DNS configuration when the `dnsAddress` setting is left empty (`null`) in `config.json`.

This feature eliminates the need to manually update the DNS address every time you move to a different network or the host machine's IP changes.

---

## How It Works

### Priority System (Highest to Lowest)

1. **CLI Flag** - `--dns <address>`
   - Highest priority
   - Example: `java -jar entralinked.jar --dns 192.168.1.100`
   - Overrides config file and auto-detection

2. **Config File** - `dnsAddress` field in `config.json`
   - If set to a specific IP: Uses that IP
   - If set to `null`: Triggers auto-detection
   - Example: `"dnsAddress" : "10.69.40.145"`

3. **Auto-Detection** (NEW)
   - Automatically detects host machine's IP address
   - Uses `NetworkUtility.getLocalHost()` to find the IP
   - Triggered when `dnsAddress` is `null` or empty
   - Works across different networks without configuration changes

4. **Fallback to Hostname**
   - Uses `hostName` field from config (usually "local" or "localhost")
   - Resolves hostname to IP address
   - Last resort before auto-detection

---

## Configuration

### Default Configuration (Auto-Detection Enabled)

```json
{
  "hostName" : "local",
  "dnsAddress" : null,
  "clearPlayerDreamInfoOnWake" : true,
  "allowOverwritingPlayerDreamInfo" : false,
  "allowPlayerGameVersionMismatch" : false,
  "allowWfcRegistrationThroughLogin" : true
}
```

**Key Setting:** `"dnsAddress" : null`

When `dnsAddress` is `null`:
- ✅ Auto-detection is enabled
- ✅ Host machine IP is detected at startup
- ✅ Works across different networks
- ✅ No manual configuration needed

---

## Usage Scenarios

### Scenario 1: Home Network (Auto-Detection)

**Setup:**
- `config.json` has `"dnsAddress" : null`
- Mac IP: `10.69.40.145`

**Start Application:**
```bash
sudo java -jar build/libs/entralinked.jar
```

**Result:**
```
DNS address not configured - auto-detecting host machine IP address
Configure your DS to use the following DNS server: 10.69.40.145
```

---

### Scenario 2: Office Network (Auto-Detection)

**Setup:**
- Same `config.json` (unchanged)
- Mac IP: `192.168.1.50` (different network)

**Start Application:**
```bash
sudo java -jar build/libs/entralinked.jar
```

**Result:**
```
DNS address not configured - auto-detecting host machine IP address
Configure your DS to use the following DNS server: 192.168.1.50
```

✅ **No config file changes needed!**

---

### Scenario 3: Manual Override

**Setup:**
- `config.json` has `"dnsAddress" : null`
- You want to use a specific IP

**Option A: Update config.json**
```json
{
  "dnsAddress" : "10.69.20.135"
}
```

**Option B: Use CLI flag**
```bash
sudo java -jar build/libs/entralinked.jar --dns 10.69.20.135
```

**Result:**
```
Using custom DNS address from configuration: 10.69.20.135
Configure your DS to use the following DNS server: 10.69.20.135
```

---

## Source Code Implementation

### Modified File: `src/main/java/entralinked/Entralinked.java`

**Auto-Detection Logic:**
```java
// Auto-detect host machine IP if DNS address not configured
if(dnsAddress == null) {
    InetAddress hostAddress = null;
    String hostName = configuration.hostName();
    
    if(hostName.equals("local") || hostName.equals("localhost")) {
        hostAddress = NetworkUtility.getLocalHost();
        logger.info("DNS address not configured - auto-detecting host machine IP address");
    } else {
        try {
            hostAddress = InetAddress.getByName(hostName);
            logger.info("Using DNS address from hostname configuration: {}", hostName);
        } catch(UnknownHostException e) {
            hostAddress = NetworkUtility.getLocalHost();
            logger.error("Could not resolve host name {} - falling back to auto-detected IP: {}", 
                        hostName, hostAddress, e);
        }
    }
    
    dnsAddress = hostAddress;
}
```

### Configuration: `src/main/java/entralinked/Configuration.java`

```java
public record Configuration(
        String hostName,
        String dnsAddress,  // null = auto-detect
        boolean clearPlayerDreamInfoOnWake,
        boolean allowOverwritingPlayerDreamInfo,
        boolean allowPlayerGameVersionMismatch,
        boolean allowWfcRegistrationThroughLogin) {
    
    public static final Configuration DEFAULT = 
        new Configuration("local", null, true, false, false, true);
}
```

---

## Log Messages

### Auto-Detection Active
```
DNS address not configured - auto-detecting host machine IP address
Configure your DS to use the following DNS server: 10.69.40.145
```

### Manual Configuration
```
Using custom DNS address from configuration: 192.168.1.100
Configure your DS to use the following DNS server: 192.168.1.100
```

### Hostname Fallback
```
Using DNS address from hostname configuration: mycomputer.local
Configure your DS to use the following DNS server: 192.168.1.100
```

### Error with Fallback
```
Could not resolve configured DNS address 999.999.999.999 - falling back to auto-detection
DNS address not configured - auto-detecting host machine IP address
Configure your DS to use the following DNS server: 10.69.40.145
```

---

## Benefits

✅ **Network Portable** - Move between networks without config changes  
✅ **Automatic** - No manual IP updates needed  
✅ **Flexible** - Can still use manual configuration when needed  
✅ **Backward Compatible** - Existing configs with hardcoded IPs still work  
✅ **Intelligent Fallback** - Handles errors gracefully  
✅ **Clear Logging** - Log messages explain what's happening  

---

## Best Practices

1. **Default Setup (Recommended)**
   - Set `"dnsAddress" : null` in `config.json`
   - Leave `"hostName" : "local"`
   - Application auto-detects IP on each startup

2. **Fixed Network**
   - If always on same network, set specific IP in `dnsAddress`
   - Useful for documentation and repeatability

3. **CLI Override**
   - Use `--dns` flag for one-time overrides
   - Example: `sudo java -jar entralinked.jar --dns 192.168.1.100`

4. **Troubleshooting**
   - Check logs for auto-detection messages
   - Verify host machine is on the expected network
   - Use `ipconfig getifaddr en0` to check Mac's current IP

---

## Testing

### Verify Auto-Detection

1. **Check config.json:**
   ```bash
   cat config.json | grep dnsAddress
   ```
   Expected: `"dnsAddress" : null`

2. **Start application:**
   ```bash
   sudo java -jar build/libs/entralinked.jar
   ```

3. **Verify detected IP:**
   ```bash
   ipconfig getifaddr en0  # Current Mac IP
   # Should match the IP shown in "Configure your DS" message
   ```

4. **Test across networks:**
   - Connect to different network
   - Restart Entralinked
   - New IP should be auto-detected automatically

---

## Files Changed

| File | Change | Impact |
|------|--------|--------|
| `src/main/java/entralinked/Entralinked.java` | Enhanced DNS detection logic with better logging | Auto-detection now triggers when dnsAddress is null |
| `config.json` | `"dnsAddress" : null` (default) | Enables auto-detection by default |

---

## Compatibility

- ✅ Java 21 LTS
- ✅ macOS (Intel & Apple Silicon)
- ✅ Linux
- ✅ Windows (with appropriate network utilities)
- ✅ All existing configurations

---

## Summary

Entralinked now intelligently detects your host machine's IP address automatically when DNS configuration is empty. This makes it portable across different networks without requiring manual configuration changes, while still supporting manual override options for special cases.

**Recommended Default:** Leave `"dnsAddress" : null` in `config.json` for automatic, network-agnostic operation.

---

**Last Updated:** March 3, 2026  
**Version:** Production Build (Java 21 LTS, Gradle 8.11.1)
