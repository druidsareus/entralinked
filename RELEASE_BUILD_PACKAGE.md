# Release Build Package Instructions

This document explains how to create and upload the prebuilt release package.

## Prerequisites

- Java 17+ Development Kit
- Git
- GitHub CLI (optional, for automated uploads)
- Gradle (included in repository)

## Building the Release Package

### Step 1: Clean and Build

```bash
cd /path/to/entralinked
./gradlew clean dist
```

This creates: `build/libs/entralinked.jar`

### Step 2: Create Release Package Directory

```bash
mkdir -p release_package/entralinked-dns-enhancement
cd release_package/entralinked-dns-enhancement
```

### Step 3: Copy Built Application

```bash
cp ../../build/libs/entralinked.jar .
```

### Step 4: Create README for Release

Create `README.md`:
```markdown
# Entralinked DNS Configuration Enhancement

## Quick Start

1. Ensure Java 17+ is installed
2. Download entralinked.jar
3. Run: `java -jar entralinked.jar`
4. Click Settings tab to configure DNS

## Features

- GUI Settings tab for DNS configuration
- Command-line --dns flag support
- Configuration file support
- 16+ C-Gear skins
- 9 Pokédex skins
- 2 musicals
- Full backward compatibility

## Configuration

### GUI Method (Recommended)
1. Launch application
2. Click Settings tab
3. Enter DNS address
4. Click Test Address
5. Click Save Settings
6. Restart

### CLI Method
```
java -jar entralinked.jar --dns 192.168.1.100
```

### Config File Method
Edit config.json:
```json
{
  "dnsAddress": "192.168.1.100"
}
```

## System Requirements

- Java 17 or higher
- 512 MB RAM
- 200 MB disk space

## Documentation

See included documentation files in the repository for detailed guides.

## Version

v1.0.0-dns-enhancement
```

### Step 5: Copy Documentation Files

```bash
cp ../../SETTINGS_TAB.md .
cp ../../DNS_CONFIGURATION_UPDATED.md .
cp ../../QUICK_REFERENCE.md .
cp ../../IMPLEMENTATION_GUIDE.md .
cp ../../RELEASE_NOTES.md .
cp ../../BUILD_INSTRUCTIONS.md .
```

### Step 6: Create ZIP Package

```bash
cd ..
zip -r entralinked-dns-enhancement.zip entralinked-dns-enhancement/
```

This creates: `entralinked-dns-enhancement.zip`

### Step 7: Verify Package

```bash
unzip -l entralinked-dns-enhancement.zip
```

Should contain:
- entralinked.jar
- README.md
- SETTINGS_TAB.md
- DNS_CONFIGURATION_UPDATED.md
- QUICK_REFERENCE.md
- IMPLEMENTATION_GUIDE.md
- RELEASE_NOTES.md
- BUILD_INSTRUCTIONS.md

## Uploading to GitHub Release

### Method 1: GitHub Web Interface

1. Go to https://github.com/druidsareus/entralinked/releases
2. Find v1.0.0-dns-enhancement release
3. Click "Edit" button
4. Scroll to "Attach binaries" section
5. Drag and drop `entralinked-dns-enhancement.zip`
6. Click "Update release"

### Method 2: Using GitHub CLI

```bash
gh release upload v1.0.0-dns-enhancement entralinked-dns-enhancement.zip
```

### Method 3: Using curl

```bash
curl -X POST \
  -H "Authorization: token YOUR_GITHUB_TOKEN" \
  -H "Content-Type: application/zip" \
  --data-binary @entralinked-dns-enhancement.zip \
  "https://api.github.com/repos/druidsareus/entralinked/releases/assets"
```

## Release Package Contents

The ZIP file should contain:

```
entralinked-dns-enhancement/
├── entralinked.jar (prebuilt application)
├── README.md (quick start guide)
├── SETTINGS_TAB.md (GUI documentation)
├── DNS_CONFIGURATION_UPDATED.md (configuration guide)
├── QUICK_REFERENCE.md (quick examples)
├── IMPLEMENTATION_GUIDE.md (technical details)
├── RELEASE_NOTES.md (release information)
└── BUILD_INSTRUCTIONS.md (build guide)
```

Total size: ~200-300 MB (including JAR)

## Verification

After uploading:

1. Visit https://github.com/druidsareus/entralinked/releases/tag/v1.0.0-dns-enhancement
2. Verify ZIP file appears in "Assets" section
3. Download and test the ZIP file
4. Verify JAR launches correctly
5. Test DNS configuration

## Usage for End Users

1. Download entralinked-dns-enhancement.zip
2. Extract zip file
3. Navigate to extracted directory
4. Run: `java -jar entralinked.jar`
5. Configure DNS via Settings tab or CLI

## Troubleshooting

### JAR won't run
- Verify Java 17+: `java -version`
- Ensure JAR is not corrupted
- Try: `java -jar entralinked.jar --version`

### Settings tab missing
- Pull latest source code
- Rebuild with: `./gradlew dist`

### DLC not loading
- Ensure resources are in build
- Check log output for errors

## Next Steps

1. Build the application: `./gradlew dist`
2. Create the ZIP package following steps above
3. Upload to GitHub release
4. Announce release to users

