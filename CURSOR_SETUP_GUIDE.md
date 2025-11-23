# Cursor IDE에서 Flutter/Dart 설정 가이드

## 1. Dart/Flutter 확장 프로그램 확인 및 설치

### 확장 프로그램 확인 방법:
1. **Cursor에서 확장 프로그램 열기**
   - `Ctrl + Shift + X` (또는 왼쪽 사이드바의 확장 프로그램 아이콘 클릭)

2. **확인해야 할 확장 프로그램:**
   - **Dart** (Dart Code Team에서 제공)
   - **Flutter** (Dart Code Team에서 제공)
   
3. **설치되지 않은 경우:**
   - 검색창에 "Dart" 또는 "Flutter" 입력
   - "Dart" 확장 프로그램 설치 (Flutter 확장 프로그램은 Dart와 함께 설치됨)
   - 설치 후 Cursor 재시작

## 2. Flutter SDK 경로 확인

### 방법 1: 명령 프롬프트에서 확인
```powershell
where flutter
```
또는
```powershell
flutter --version
```

### 방법 2: 환경 변수 확인
1. Windows 키 + R → `sysdm.cpl` 입력
2. 고급 탭 → 환경 변수 클릭
3. 시스템 변수에서 `Path` 선택 → 편집
4. Flutter SDK 경로 확인 (예: `C:\flutter\bin`)

## 3. Cursor에서 Flutter SDK 경로 설정

### 설정 파일 생성:
1. 프로젝트 루트에 `.vscode` 폴더 생성 (없는 경우)
2. `.vscode/settings.json` 파일 생성 또는 수정

### settings.json 예시:
```json
{
  "dart.flutterSdkPath": "C:\\flutter",
  "dart.sdkPath": "C:\\flutter\\bin\\cache\\dart-sdk",
  "dart.analysisExcludedFolders": [
    ".dart_tool",
    ".pub",
    "build"
  ]
}
```

**주의:** `C:\\flutter`를 실제 Flutter SDK 설치 경로로 변경하세요.

## 4. Dart 분석 서버 재시작

설정 변경 후:
1. `Ctrl + Shift + P` (또는 `Cmd + Shift + P`)
2. "Dart: Restart Analysis Server" 입력 후 실행

## 5. 문제 해결 체크리스트

- [ ] Dart 확장 프로그램이 설치되어 있는가?
- [ ] Flutter 확장 프로그램이 설치되어 있는가?
- [ ] Flutter SDK가 올바른 경로에 설치되어 있는가?
- [ ] 환경 변수 PATH에 Flutter bin 경로가 포함되어 있는가?
- [ ] `flutter doctor` 명령어가 정상 작동하는가?
- [ ] Cursor를 재시작했는가?
- [ ] Dart 분석 서버를 재시작했는가?

## 6. 추가 확인 사항

### Flutter 설치 확인:
```powershell
flutter doctor -v
```

### 프로젝트 의존성 확인:
```powershell
flutter pub get
```

### 패키지 캐시 정리 (문제 발생 시):
```powershell
flutter clean
flutter pub get
```

