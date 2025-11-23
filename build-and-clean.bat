@echo off
REM Flutter 빌드 후 Gradle 데몬 자동 중지 스크립트 (Windows)

echo ========================================
echo Flutter Build and Clean Script
echo ========================================
echo.

REM Flutter clean
echo [1/3] Cleaning Flutter project...
call flutter clean
if %ERRORLEVEL% NEQ 0 (
    echo Flutter clean failed!
    exit /b %ERRORLEVEL%
)

REM Flutter pub get
echo [2/3] Getting Flutter dependencies...
call flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo Flutter pub get failed!
    exit /b %ERRORLEVEL%
)

REM Build
echo [3/3] Building Flutter app...
call flutter build apk
if %ERRORLEVEL% NEQ 0 (
    echo Build failed!
    goto :stop_daemon
)

echo.
echo ========================================
echo Build successful!
echo ========================================
echo.

:stop_daemon
REM Stop Gradle daemon to free memory
echo Stopping Gradle daemon to free memory...
cd android
call gradlew.bat --stop
cd ..

echo.
echo Done! Gradle daemon stopped.
pause

