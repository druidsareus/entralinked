# Entralinked DNS Configuration Release

## Version
Current Release: DNS Configuration Enhancement

## What's New

### 🎯 Major Features

**GUI Settings Tab**
- Intuitive DNS configuration interface
- Real-time address validation
- Save and reset controls
- One-click configuration

**Configuration Methods**
- GUI Settings tab (easiest)
- Command-line `--dns` flag
- Configuration file (`config.json`)
- Auto-detection fallback

**Three-Tier Priority System**
1. CLI `--dns` flag (highest)
2. Configuration file `dnsAddress`
3. Configuration file `hostName`
4. Auto-detection (default)

## Installation

### Prerequisites
- Java 17 Development Kit or higher

### Build
```bash
git clone --recurse-submodules https://github.com/druidsareus/entralinked.git
cd entralinked
./gradlew dist
```

### Run
```bash
java -jar build/libs/entralinked.jar
```

## Usage

### GUI Method (Recommended)
1. Launch: `java -jar entralinked.jar`
2. Click Settings tab
3. Enter DNS address (e.g., `192.168.1.100`)
4. Click "Test Address" to verify
5. Click "Save Settings"
6. Restart application

### Command-Line Method
```bash
java -jar entralinked.jar --dns 192.168.1.100
```

Supports both IPv4 addresses and hostnames:
```bash
java -jar entralinked.jar --dns game-server.local
```

### Configuration File Method
Edit `config.json`:
```json
{
  "dnsAddress": "192.168.1.100"
}
```

## Features

✅ Real-time hostname resolution  
✅ Visual validation feedback (✓/✗)  
✅ Color-coded status messages  
✅ Persistent configuration  
✅ Graceful error handling  
✅ 100% backward compatible  
✅ No breaking changes  
✅ Comprehensive documentation  

## Documentation

- **SETTINGS_TAB.md** - How to use the GUI Settings tab
- **DNS_CONFIGURATION_UPDATED.md** - Configuration reference
- **QUICK_REFERENCE.md** - Quick start examples
- **IMPLEMENTATION_GUIDE.md** - Technical documentation
- **DELIVERABLES.md** - Summary of changes

## Included Content

### Base Application
- Game Sync emulator for Pokémon Black & White
- Memory Link support
- Dashboard interface

### Default DLC Content
- Pokédex skins
- C-Gear skins
- Musicals
- Join Avenue visitors (B2W2)

### DNS Configuration
- New Settings tab in GUI
- CLI flag support
- Configuration file support
- Real-time validation

## System Requirements

- **OS**: Windows, macOS, Linux
- **Java**: 17 or higher
- **RAM**: 512 MB minimum
- **Disk**: 200 MB for application + content

## Changes in This Release

### Source Code
- Added `SettingsPanel.java` (228 lines)
- Enhanced `Configuration.java`
- Enhanced `CommandLineArguments.java`
- Refactored DNS resolution in `Entralinked.java`
- Integrated Settings tab in `MainView.java`

### Documentation
- Added comprehensive guides
- Written in project style
- Multiple reference formats
- Usage examples included

## Support

### Getting Help
1. Check QUICK_REFERENCE.md for common tasks
2. See SETTINGS_TAB.md for GUI usage
3. Review IMPLEMENTATION_GUIDE.md for technical details

### Common Issues

**"Cannot resolve DNS address"**
- Verify address is reachable
- Check network connectivity
- Try with IP address instead of hostname

**"Settings won't save"**
- Ensure config.json is writable
- Check file permissions
- Verify DNS address format

**"DS still can't connect"**
- Check reported DNS in Console tab
- Verify DS settings point to reported address
- Ensure port 53 is not blocked by firewall

## Backward Compatibility

✅ **100% backward compatible**

- Existing configurations work unchanged
- No breaking changes
- Optional feature enhancement
- Graceful degradation if DNS not configured

## License

See LICENSE.md for license information.

## Credits

Based on Entralinked by kuroppoi  
DNS Configuration Enhancement added with comprehensive documentation

## Version History

### Current
- Added GUI Settings tab for DNS configuration
- Added CLI --dns flag support
- Added configuration file support
- Added comprehensive documentation
- 100% backward compatible

### Previous
- Original Entralinked features
- Game Sync emulation
- Memory Link support
- DLC content management

---

For more information and documentation, see the included markdown files.

