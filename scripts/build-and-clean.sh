#!/bin/bash
# Gradle 빌드 후 자동으로 데몬 중지하는 스크립트 (Linux/Mac용)

cd android

echo "Building with Gradle..."
./gradlew "$@"

BUILD_STATUS=$?

if [ $BUILD_STATUS -eq 0 ]; then
    echo "Build successful!"
    echo "Stopping Gradle daemon to free memory..."
    ./gradlew --stop
    echo "Gradle daemon stopped."
else
    echo "Build failed!"
    echo "Stopping Gradle daemon anyway..."
    ./gradlew --stop
    exit $BUILD_STATUS
fi

