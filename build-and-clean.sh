#!/bin/bash
# Flutter 빌드 후 Gradle 데몬 자동 중지 스크립트 (Linux/Mac)

set -e

echo "========================================"
echo "Flutter Build and Clean Script"
echo "========================================"
echo ""

# Flutter clean
echo "[1/3] Cleaning Flutter project..."
flutter clean

# Flutter pub get
echo "[2/3] Getting Flutter dependencies..."
flutter pub get

# Build
echo "[3/3] Building Flutter app..."
if flutter build apk; then
    echo ""
    echo "========================================"
    echo "Build successful!"
    echo "========================================"
    echo ""
else
    echo "Build failed!"
fi

# Stop Gradle daemon to free memory
echo "Stopping Gradle daemon to free memory..."
cd android
./gradlew --stop
cd ..

echo ""
echo "Done! Gradle daemon stopped."

