# Flutter 항공앱 실행 명령어 모음

## 기본 명령어
```bash
# Flutter 버전 확인
flutter --version

# Flutter 환경 확인
flutter doctor

# 의존성 설치
flutter pub get

# 사용 가능한 디바이스 확인
flutter devices

# 앱 실행
flutter run

# 특정 디바이스에서 실행
flutter run -d <device-id>

# 핫 리로드 (실행 중 코드 변경 시)
r

# 핫 리스타트 (실행 중 전체 앱 재시작)
R

# 앱 종료
q
```

## 개발 명령어
```bash
# 클린 빌드
flutter clean
flutter pub get

# 릴리즈 빌드
flutter build apk --release

# 디버그 빌드
flutter build apk --debug

# 앱 번들 생성 (Google Play Store용)
flutter build appbundle --release
```

## 문제 해결
```bash
# Flutter 업그레이드
flutter upgrade

# Flutter 채널 확인
flutter channel

# Flutter 채널 변경 (stable 권장)
flutter channel stable
flutter upgrade

# 캐시 정리
flutter clean
flutter pub cache repair
```

## 디바이스 관련
```bash
# 연결된 디바이스 목록
flutter devices

# 에뮬레이터 목록
flutter emulators

# 에뮬레이터 실행
flutter emulators --launch <emulator-id>

# ADB 디바이스 확인
adb devices
```



