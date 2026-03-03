# Build and Deployment Instructions

## Prerequisites

- Java 17 Development Kit or higher
- Git
- Gradle (included via gradlew)

## Building from Source

### 1. Clone Repository

```bash
git clone --recurse-submodules https://github.com/druidsareus/entralinked.git
cd entralinked
```

### 2. Build with Gradle

```bash
# On macOS/Linux
./gradlew dist

# On Windows
gradlew.bat dist
```

The build will:
- Compile all source code
- Include DNS configuration enhancements
- Include all DLC content (PCN skins, C-Gear skins, musicals)
- Create `build/libs/entralinked.jar`

### 3. Run Application

```bash
java -jar build/libs/entralinked.jar
```

## DNS Configuration

### GUI Settings (Easiest)
1. Launch application
2. Click "Settings" tab
3. Enter DNS address
4. Click "Test Address" to validate
5. Click "Save Settings"
6. Restart application

### Command-Line

```bash
# With IP address
java -jar build/libs/entralinked.jar --dns 192.168.1.100

# With hostname
java -jar build/libs/entralinked.jar --dns game-server.local

# Without GUI
java -jar build/libs/entralinked.jar disablegui --dns 192.168.1.100
```

### Configuration File

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

## Included Content

### DLC/Skins
- **C-Gear Skins**: 16+ designs
- **Pokédex Skins**: 9 variations
- **Musicals**: 2 scenarios
- **Join Avenue Visitors**: Multiple profiles (B2W2)

Location: `src/main/resources/dlc/IRAO/`

### Documentation

- `SETTINGS_TAB.md` - GUI usage guide
- `DNS_CONFIGURATION_UPDATED.md` - Configuration reference
- `QUICK_REFERENCE.md` - Quick examples
- `IMPLEMENTATION_GUIDE.md` - Technical details
- `RELEASE_NOTES.md` - Release information

## Deployment Options

### Option 1: Local Installation
1. Build application
2. Copy `entralinked.jar` to desired location
3. Run with `java -jar entralinked.jar`
4. Configure DNS via GUI Settings tab

### Option 2: Server Installation
1. Deploy on server with Java 17+
2. Configure DNS via command-line flag or config file
3. Provide network IP to DS systems

### Option 3: Network Share
1. Place JAR on network share
2. Users run from shared location
3. Config file stored locally or on share

## Verification

After building:

1. **Check build output:**
   ```bash
   ls -la build/libs/entralinked.jar
   ```

2. **Verify application launches:**
   ```bash
   java -jar build/libs/entralinked.jar --version
   ```

3. **Test DNS configuration:**
   - Launch application
   - Click Settings tab
   - Enter test DNS address
   - Verify settings save

4. **Verify DLC content:**
   - Access Game Sync
   - Check C-Gear skins
   - Check Pokédex skins
   - Verify musicals load

## Troubleshooting

### Build Fails
- Ensure Java 17+ is installed: `java -version`
- Clean build: `./gradlew clean dist`
- Check permissions: `chmod +x gradlew`

### Application Won't Start
- Verify Java installation: `java -version`
- Check JAR integrity: `java -jar entralinked.jar`
- Review logs for errors

### DNS Not Working
- Verify hostname/IP format
- Test with `--dns` flag first
- Check network connectivity
- Ensure port 53 is accessible

### Settings Won't Save
- Verify `config.json` exists
- Check file permissions
- Ensure working directory is writable

## What's Included

### Source Code Changes
- `src/main/java/entralinked/Configuration.java`
- `src/main/java/entralinked/CommandLineArguments.java`
- `src/main/java/entralinked/Entralinked.java`
- `src/main/java/entralinked/gui/view/MainView.java`
- `src/main/java/entralinked/gui/panels/SettingsPanel.java` (NEW)

### Default DLC
- 16+ C-Gear skins
- 9 Pokédex skins
- 2 musical files
- Multiple join avenue profiles

### Documentation
- 6 comprehensive markdown files
- Usage examples
- Technical specifications
- Troubleshooting guide

## Support

For issues or questions:
1. Check QUICK_REFERENCE.md for common commands
2. Review SETTINGS_TAB.md for GUI help
3. See IMPLEMENTATION_GUIDE.md for technical details
4. Check RELEASE_NOTES.md for version information

## Next Steps

1. **Build**: `./gradlew dist`
2. **Run**: `java -jar build/libs/entralinked.jar`
3. **Configure DNS**: Use Settings tab or CLI flag
4. **Verify**: Check Console for DNS confirmation
5. **Share**: Distribute JAR to end users

---

For more information, see the included documentation files.

