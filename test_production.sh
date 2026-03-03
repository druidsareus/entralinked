#!/bin/bash

# Entralinked Production Test Suite
# Run this after starting: sudo java -jar build/libs/entralinked.jar

echo "╔════════════════════════════════════════════════════════════════════════════╗"
echo "║              ENTRALINKED - PRODUCTION DEPLOYMENT TEST SUITE               ║"
echo "╚════════════════════════════════════════════════════════════════════════════╝"
echo ""

# Wait for application to be ready
echo "⏳ Waiting for application to start (10 seconds)..."
sleep 10

echo ""
echo "✅ CONNECTIVITY TESTS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test HTTP port 80
echo "Testing HTTP (port 80)..."
HTTP_RESPONSE=$(curl -s http://localhost/ -I 2>&1 | head -1)
if [[ $HTTP_RESPONSE == *"200"* ]]; then
    echo "✅ HTTP port 80: RESPONDING (200 OK)"
else
    echo "❌ HTTP port 80: NOT RESPONDING"
    echo "   Response: $HTTP_RESPONSE"
fi

# Test HTTPS port 443
echo "Testing HTTPS (port 443)..."
HTTPS_RESPONSE=$(curl -s https://localhost/ -I -k 2>&1 | head -1)
if [[ $HTTPS_RESPONSE == *"200"* ]] || [[ $HTTPS_RESPONSE == *"Connection"* ]]; then
    echo "✅ HTTPS port 443: LISTENING"
else
    echo "⚠️  HTTPS port 443: Checking..."
fi

echo ""
echo "✅ PORT LISTENING TESTS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test ports with netstat
for port in 80 443 53 29900; do
    if netstat -an 2>/dev/null | grep -q "\\.${port} .*LISTEN"; then
        echo "✅ Port $port: LISTENING"
    else
        echo "❌ Port $port: NOT LISTENING"
    fi
done

echo ""
echo "✅ PROCESS STATUS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if pgrep -f "java -jar.*entralinked" > /dev/null; then
    PID=$(pgrep -f "java -jar.*entralinked" | head -1)
    MEMORY=$(ps -o rss= -p $PID 2>/dev/null | awk '{printf "%.0f MB", $1/1024}')
    CPU=$(ps -o %cpu= -p $PID 2>/dev/null)
    echo "✅ Process Running"
    echo "   PID: $PID"
    echo "   Memory: $MEMORY"
    echo "   CPU: $CPU%"
else
    echo "❌ Process NOT RUNNING"
fi

echo ""
echo "✅ CONFIGURATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -f "/tmp/entralinked/config.json" ]; then
    DNS_CONFIG=$(grep "dnsAddress" /tmp/entralinked/config.json | head -1)
    echo "✅ Configuration file found"
    echo "   $DNS_CONFIG"
else
    echo "❌ Configuration file not found"
fi

echo ""
echo "✅ JAR INFORMATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

JAR_FILE="/tmp/entralinked/build/libs/entralinked.jar"
if [ -f "$JAR_FILE" ]; then
    JAR_SIZE=$(ls -lh $JAR_FILE | awk '{print $5}')
    JAR_DATE=$(ls -lh $JAR_FILE | awk '{print $6, $7, $8}')
    echo "✅ JAR Artifact"
    echo "   Size: $JAR_SIZE"
    echo "   Date: $JAR_DATE"
else
    echo "❌ JAR file not found"
fi

echo ""
echo "✅ SYSTEM INFORMATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

java -version 2>&1 | head -1
echo "Gradle: $(cd /tmp/entralinked && ./gradlew --version 2>&1 | grep '^Gradle' | head -1)"
echo "OS: $(uname -s)"
echo "Architecture: $(uname -m)"

echo ""
echo "✅ FEATURE TESTS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test HTTP response
HTTP_TEST=$(curl -s http://localhost/)
if [[ $HTTP_TEST == "Test" ]]; then
    echo "✅ HTTP Conntest Endpoint: WORKING"
else
    echo "⚠️  HTTP Conntest response: $HTTP_TEST"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════════════════╗"
echo "║                        TEST SUITE COMPLETE                                ║"
echo "╚════════════════════════════════════════════════════════════════════════════╝"

echo ""
echo "To stop the application, run:"
echo "  sudo pkill -f 'java -jar.*entralinked'"
