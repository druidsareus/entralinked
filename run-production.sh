#!/bin/bash
# Entralinked Production Startup Script
# Run with: sudo bash run-production.sh

cd /tmp/entralinked
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

echo "=========================================="
echo "Entralinked - Production Deployment"
echo "=========================================="
echo "DNS Address: 10.69.20.135"
echo "HTTP Port: 80"
echo "HTTPS Port: 443"
echo "=========================================="
echo ""

java -jar build/libs/entralinked.jar --dns 10.69.20.135
