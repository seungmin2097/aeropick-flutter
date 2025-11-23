# 플러터 항공앱 단계별 실행 가이드

## 🚀 Step 1: Flutter 설치
1. **Flutter SDK 다운로드**
   - https://flutter.dev/docs/get-started/install/windows
   - "Get the Flutter SDK" 클릭

2. **압축 해제**
   ```
   C:\flutter\ (권장 경로)
   ```

3. **환경변수 설정**
   - Windows 키 + R → `sysdm.cpl` → 고급 → 환경 변수
   - 시스템 변수 → Path → 편집 → 새로 만들기
   - `C:\flutter\bin` 추가

4. **설치 확인**
   ```bash
   # 새 명령 프롬프트에서
   flutter doctor
   ```

## 🚀 Step 2: Android Studio 설정
1. **Android Studio 다운로드 및 설치**
   - https://developer.android.com/studio

2. **Flutter 플러그인 설치**
   - Android Studio 실행
   - File → Settings → Plugins
   - "Flutter" 검색 후 설치
   - "Dart" 플러그인도 함께 설치됨

3. **Android SDK 설정**
   - Tools → SDK Manager
   - Android SDK Platform (API 30 이상) 설치
   - Android SDK Build-Tools 설치

## 🚀 Step 3: 디바이스 준비
### 실제 안드로이드 기기 사용 시:
1. **개발자 옵션 활성화**
   - 설정 → 휴대전화 정보 → 빌드 번호 7번 탭

2. **USB 디버깅 활성화**
   - 설정 → 개발자 옵션 → USB 디버깅 ON

3. **기기 연결**
   - USB 케이블로 PC와 연결
   - "USB 디버깅 허용" 확인

### 에뮬레이터 사용 시:
1. **AVD Manager 실행**
   - Android Studio → Tools → AVD Manager

2. **가상 디바이스 생성**
   - "Create Virtual Device" 클릭
   - Pixel 4 또는 원하는 기기 선택
   - API 30 이상 선택

3. **에뮬레이터 실행**
   - 생성된 디바이스 옆의 ▶️ 버튼 클릭

## 🚀 Step 4: 프로젝트 실행
1. **의존성 설치**
   ```bash
   flutter pub get
   ```

2. **디바이스 확인**
   ```bash
   flutter devices
   ```

3. **앱 실행**
   ```bash
   flutter run
   ```

## 🚀 Step 5: Android Studio에서 실행
1. **프로젝트 열기**
   - Android Studio → Open
   - `C:\Users\smlo2\Documents\cursor.series` 선택

2. **Flutter 프로젝트 인식 확인**
   - 프로젝트가 Flutter 프로젝트로 인식되는지 확인

3. **디바이스 선택**
   - 상단 툴바에서 디바이스 선택

4. **실행**
   - ▶️ Run 버튼 클릭 또는 Shift + F10

## 🚀 Step 6: 실행 확인
- [ ] 앱이 정상적으로 시작됨
- [ ] 홈 화면이 표시됨
- [ ] 하단 네비게이션 동작
- [ ] 각 화면 전환 가능
- [ ] 검색 기능 동작
- [ ] 로그인 기능 동작

## 🚨 문제 해결
### Flutter 명령어 인식 안됨
- 환경변수 PATH 재확인
- 명령 프롬프트 재시작

### 디바이스 인식 안됨
- USB 드라이버 재설치
- USB 디버깅 재확인
- 다른 USB 포트 사용

### 빌드 오류
```bash
flutter clean
flutter pub get
flutter run
```

### 의존성 오류
- 인터넷 연결 확인
- 방화벽 설정 확인
- 프록시 설정 확인



