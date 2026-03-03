#!/bin/bash

# Entralinked Release Package Creator
# Creates a prebuilt ZIP package for GitHub releases

set -e

echo "=========================================="
echo "Entralinked Release Package Creator"
echo "=========================================="
echo ""

# Check if we're in the right directory
if [ ! -f "build.gradle" ]; then
    echo "Error: build.gradle not found. Please run this script from the project root."
    exit 1
fi

# Clean and build
echo "[1/6] Cleaning previous build..."
./gradlew clean >/dev/null 2>&1

echo "[2/6] Building application..."
./gradlew dist >/dev/null 2>&1

# Check if build succeeded
if [ ! -f "build/libs/entralinked.jar" ]; then
    echo "Error: Build failed. JAR not created."
    exit 1
fi

echo "[3/6] Creating package directory..."
mkdir -p release_package/entralinked-dns-enhancement
cd release_package/entralinked-dns-enhancement

echo "[4/6] Copying files..."
cp ../../build/libs/entralinked.jar .
cp ../../SETTINGS_TAB.md .
cp ../../DNS_CONFIGURATION_UPDATED.md .
cp ../../QUICK_REFERENCE.md .
cp ../../IMPLEMENTATION_GUIDE.md .
cp ../../RELEASE_NOTES.md .
cp ../../BUILD_INSTRUCTIONS.md .

# Create quick start README
cat > README.md << 'READMEEOF'
# Entralinked DNS Configuration Enhancement v1.0.0

## Quick Start

1. **Ensure Java 17+ is installed:**
   ```
   java -version
   ```

2. **Extract this ZIP file**

3. **Run the application:**
   ```
   java -jar entralinked.jar
   ```

4. **Configure DNS (GUI Method - Easiest):**
   - Click "Settings" tab
   - Enter DNS address (e.g., 192.168.1.100)
   - Click "Test Address"
   - Click "Save Settings"
   - Restart application

## Features

✅ GUI Settings tab for DNS configuration  
✅ Command-line --dns flag support  
✅ Configuration file support  
✅ 16+ C-Gear skins  
✅ 9 Pokédex skins  
✅ 2 musicals  
✅ 100% backward compatible  

## Configuration Methods

### Command-Line
```
java -jar entralinked.jar --dns 192.168.1.100
java -jar entralinked.jar --dns game-server.local
```

### Config File
Edit config.json:
```json
{
  "dnsAddress": "192.168.1.100"
}
```

## System Requirements

- **Java:** 17 or higher
- **RAM:** 512 MB minimum
- **Disk:** 200 MB
- **OS:** Windows, macOS, or Linux

## Documentation

Included in this package:
- **README.md** - This file
- **QUICK_REFERENCE.md** - Quick commands
- **SETTINGS_TAB.md** - GUI usage guide
- **DNS_CONFIGURATION_UPDATED.md** - Configuration methods
- **IMPLEMENTATION_GUIDE.md** - Technical details
- **BUILD_INSTRUCTIONS.md** - Build instructions
- **RELEASE_NOTES.md** - Release information

## Troubleshooting

**"JAR file not found"**
- Ensure entralinked.jar is in the same directory as this README

**"Java not found"**
- Install Java 17 or higher
- Verify with: `java -version`

**"Settings tab not visible"**
- Ensure you're using the latest version
- Try clearing cache and restarting

**"DNS won't save"**
- Check that config.json is not read-only
- Try creating config.json manually

## Support

For detailed help, see the included documentation files.

## Version

v1.0.0-dns-enhancement

Includes DNS configuration enhancement with GUI Settings tab, comprehensive documentation, and all DLC content.
READMEEOF

echo "[5/6] Creating ZIP package..."
cd ..
zip -q -r entralinked-dns-enhancement.zip entralinked-dns-enhancement/

echo "[6/6] Verifying package..."
unzip -l entralinked-dns-enhancement.zip | head -15

# Get file size
SIZE=$(ls -lh entralinked-dns-enhancement.zip | awk '{print $5}')

echo ""
echo "=========================================="
echo "Release package created successfully!"
echo "=========================================="
echo ""
echo "Package: entralinked-dns-enhancement.zip"
echo "Size: $SIZE"
echo "Location: release_package/"
echo ""
echo "Contents:"
unzip -l entralinked-dns-enhancement.zip | tail -n +4 | head -n -2 | awk '{print "  " $4}'
echo ""
echo "Next steps:"
echo "1. Upload entralinked-dns-enhancement.zip to GitHub release"
echo "   https://github.com/druidsareus/entralinked/releases/tag/v1.0.0-dns-enhancement"
echo "2. Users can download and extract the ZIP"
echo "3. Users run: java -jar entralinked.jar"
echo ""

