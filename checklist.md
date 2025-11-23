# Flutter 항공앱 실행 전 체크리스트

## ✅ 필수 설치 항목
- [ ] Flutter SDK 설치 및 환경변수 설정
- [ ] Android Studio 설치
- [ ] Android SDK 설치 (API 21 이상)
- [ ] Flutter 플러그인 설치 (Android Studio)

## ✅ 개발 환경 확인
- [ ] `flutter doctor` 명령어로 모든 항목 체크
- [ ] Java JDK 설치 (Android Studio와 함께 설치됨)
- [ ] Git 설치 (Flutter 설치 시 필요)

## ✅ 디바이스 설정
- [ ] 실제 안드로이드 기기: USB 디버깅 활성화
- [ ] 에뮬레이터: AVD 생성 및 실행
- [ ] `flutter devices` 명령어로 디바이스 인식 확인

## ✅ 프로젝트 설정
- [ ] `flutter pub get` 실행하여 의존성 설치
- [ ] 인터넷 연결 확인 (의존성 다운로드용)
- [ ] 충분한 디스크 공간 (최소 2GB)

## ✅ 실행 확인
- [ ] `flutter run` 명령어로 앱 실행
- [ ] 앱이 정상적으로 로드되는지 확인
- [ ] 네비게이션 동작 확인
- [ ] 각 화면 전환 테스트

## 🚨 문제 발생 시
1. **Flutter 설치 문제**: 환경변수 PATH 확인
2. **디바이스 인식 안됨**: USB 드라이버 설치, USB 디버깅 재확인
3. **빌드 오류**: `flutter clean && flutter pub get` 실행
4. **의존성 오류**: 인터넷 연결 확인, 방화벽 설정 확인



