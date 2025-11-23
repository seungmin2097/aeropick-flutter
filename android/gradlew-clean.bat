@echo off
REM Gradle 빌드 후 데몬 자동 중지 스크립트

echo Cleaning Gradle build...
call gradlew.bat clean

echo Stopping Gradle daemon...
call gradlew.bat --stop

echo Done!

