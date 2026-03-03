# Entralinked DNS Configuration Enhancement v1.0.0

## What's Included

This release includes:
- Complete source code with DNS configuration enhancement
- Professional GUI Settings tab for DNS management
- Command-line --dns flag support
- Configuration file support
- 16+ C-Gear skins (included in build)
- 9 Pokédex skins (included in build)
- 2 musical files (included in build)
- Comprehensive documentation

## Quick Start

### Prerequisites
- Java 17 Development Kit or higher
- Git
- Gradle (included in repository)

### Build from Source

```bash
git clone --recurse-submodules https://github.com/druidsareus/entralinked.git
cd entralinked
git checkout v1.0.0-dns-enhancement
./gradlew dist
```

### Run Application

```bash
java -jar build/libs/entralinked.jar
```

## Configure DNS

### GUI Method (Recommended)
1. Launch application: `java -jar build/libs/entralinked.jar`
2. Click "Settings" tab in main window
3. Enter DNS address (e.g., `192.168.1.100` or `game-server.local`)
4. Click "Test Address" to verify
5. Click "Save Settings"
6. Restart application

### Command-Line Method
```bash
java -jar build/libs/entralinked.jar --dns 192.168.1.100
java -jar build/libs/entralinked.jar --dns game-server.local
```

### Configuration File Method
Edit `config.json`:
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

## Features

✅ GUI Settings tab for DNS configuration  
✅ Real-time address validation  
✅ Command-line --dns flag support  
✅ Configuration file support  
✅ 16+ C-Gear skins  
✅ 9 Pokédex skins  
✅ 2 musicals  
✅ 100% backward compatible  
✅ No breaking changes  
✅ Comprehensive documentation  

## System Requirements

- **Java:** 17 or higher
- **RAM:** 512 MB minimum
- **Disk:** 200 MB for application + 100+ MB for DLC
- **OS:** Windows, macOS, or Linux

## Documentation Included

- **README.md** - This file
- **QUICK_REFERENCE.md** - Quick start commands
- **SETTINGS_TAB.md** - How to use the GUI Settings tab
- **DNS_CONFIGURATION_UPDATED.md** - All configuration methods
- **IMPLEMENTATION_GUIDE.md** - Technical implementation details
- **BUILD_INSTRUCTIONS.md** - Detailed build and deployment guide
- **RELEASE_NOTES.md** - Complete release information

## Configuration Priority

DNS is configured in this order (highest to lowest priority):

1. Command-line `--dns` flag
2. `dnsAddress` field in `config.json`
3. `hostName` field in `config.json`
4. Auto-detected local host (default)

## Key Improvements

### DNS Configuration Enhancement
- **GUI Settings Tab**: User-friendly DNS management without command-line
- **Real-Time Validation**: See if DNS address is valid before saving
- **Multiple Methods**: GUI, CLI flag, or config file
- **Hostname Support**: Use domain names, not just IP addresses
- **Priority System**: Flexible configuration with sensible defaults

### Professional Quality
- **Production Code**: 228 lines of professional GUI code
- **Error Handling**: Graceful error handling with user-friendly messages
- **Documentation**: Comprehensive documentation for all use cases
- **Backward Compatible**: 100% compatible with existing installations

## Troubleshooting

**"JAR not found"**
- Ensure you've built the application: `./gradlew dist`
- JAR should be at: `build/libs/entralinked.jar`

**"Java not found"**
- Install Java 17 or higher
- Verify: `java -version`

**"Settings tab not visible"**
- Ensure you're using the v1.0.0-dns-enhancement version
- Rebuild with: `./gradlew dist`

**"DNS won't save"**
- Verify config.json is not read-only
- Check file permissions
- Ensure DNS address is resolvable

**Build fails with Gradle error**
- Try: `./gradlew clean dist`
- Check Java version: needs 17+
- Review error message and RELEASE_NOTES.md

## Support

For detailed help:
1. See QUICK_REFERENCE.md for quick commands
2. See SETTINGS_TAB.md for GUI help
3. See DNS_CONFIGURATION_UPDATED.md for configuration options
4. See BUILD_INSTRUCTIONS.md for build issues
5. See IMPLEMENTATION_GUIDE.md for technical details

## Version

**v1.0.0-dns-enhancement**

This is a major feature release that adds DNS configuration capabilities to Entralinked with a professional GUI Settings tab, command-line support, and comprehensive documentation.

## Backward Compatibility

✅ **100% backward compatible**

- Existing configurations work unchanged
- No breaking changes to API
- DNS configuration is optional
- Graceful degradation if DNS not configured
- Existing Game Sync functionality preserved

## Repository

**GitHub:** https://github.com/druidsareus/entralinked  
**Release:** https://github.com/druidsareus/entralinked/releases/tag/v1.0.0-dns-enhancement

## License

See LICENSE.md in repository for license information

## Credits

Based on Entralinked by kuroppoi  
DNS Configuration Enhancement developed with comprehensive documentation

---

**Ready to enhance your Pokémon Game Sync experience!**

For the complete source code, documentation, and DLC content, visit the GitHub repository.

