# Java Version Update

## Updated to Java 21 LTS

The project has been updated to support Java 21 Long-Term Support (LTS) release.

### Changes Made

#### build.gradle
- Updated `sourceCompatibility` from `VERSION_17` to `VERSION_21`
- Updated `targetCompatibility` from `VERSION_17` to `VERSION_21`

#### gradle/wrapper/gradle-wrapper.properties
- Updated Gradle from `8.1.1` to `8.11.1`
- Gradle 8.11.1 provides full support for Java 21 LTS

### Benefits

- **Java 21 LTS:** Long-term support until 2031
- **Performance:** Improved virtual thread support and performance optimizations
- **Gradle 8.11.1:** Latest stable version with better Java 21 support
- **Modern Features:** Access to recent Java language features
- **Security:** Latest security patches and updates

### Compatibility

✅ Java 21 LTS (Recommended)
✅ Java 25+ (Latest release)
✅ Gradle 8.11.1

### Building

```bash
# Ensure Java 21 or higher is installed
java -version

# Build the project
./gradlew dist

# Run the application
java -jar build/libs/entralinked.jar
```

### System Requirements

- **Java:** 21 or higher (LTS recommended)
- **Gradle:** 8.11.1 (included via wrapper)
- **Operating System:** Windows, macOS, or Linux

### Migration Notes

If you were using Java 17:
1. Install Java 21 LTS (https://adoptium.net/)
2. Run `./gradlew clean` to clear old build artifacts
3. Run `./gradlew dist` to build with Java 21

### Future Updates

Java 25 and later versions are also supported. The project will continue to be updated with the latest LTS releases:
- Java 21 LTS (Current)
- Java 23 (Latest feature release)
- Java 25+ (Latest versions)

