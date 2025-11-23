@echo off
REM Gradle 빌드 후 데몬 자동 중지 스크립트

echo Building with Gradle...
call gradlew.bat %*

if %ERRORLEVEL% EQU 0 (
    echo Build successful!
    echo Stopping Gradle daemon to free memory...
    call gradlew.bat --stop
    echo Gradle daemon stopped.
) else (
    echo Build failed!
    echo Stopping Gradle daemon anyway...
    call gradlew.bat --stop
    exit /b %ERRORLEVEL%
)

