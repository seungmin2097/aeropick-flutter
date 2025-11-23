@echo off
echo Flutter 설치를 시작합니다...

REM Flutter 설치 디렉토리 생성
if not exist "C:\flutter" (
    echo Flutter 디렉토리를 생성합니다...
    mkdir C:\flutter
)

REM Git이 설치되어 있는지 확인
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Git을 사용하여 Flutter를 설치합니다...
    cd /d C:\
    if not exist "C:\flutter\bin" (
        git clone https://github.com/flutter/flutter.git -b stable
    ) else (
        echo Flutter가 이미 설치되어 있습니다.
    )
) else (
    echo Git이 설치되어 있지 않습니다.
    echo https://flutter.dev/docs/get-started/install/windows 에서 수동으로 다운로드하세요.
    pause
    exit /b 1
)

REM 환경변수 설정 안내
echo.
echo ========================================
echo 환경변수 설정이 필요합니다:
echo 1. Windows 키 + R을 누르고 sysdm.cpl 입력
echo 2. 고급 탭 > 환경 변수 클릭
echo 3. 시스템 변수에서 Path 선택 > 편집
echo 4. 새로 만들기 > C:\flutter\bin 추가
echo 5. 확인 클릭
echo ========================================
echo.

REM Flutter 설치 확인
echo Flutter 설치를 확인합니다...
C:\flutter\bin\flutter.bat doctor

echo.
echo 설치가 완료되었습니다!
echo 새 명령 프롬프트를 열고 'flutter doctor'를 실행해보세요.
pause



