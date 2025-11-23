@echo off
echo Flutter 항공앱 실행 중...

REM Flutter 의존성 설치
echo 의존성 설치 중...
flutter pub get

REM 사용 가능한 디바이스 확인
echo 사용 가능한 디바이스:
flutter devices

REM 앱 실행
echo 앱 실행 중...
flutter run

pause



