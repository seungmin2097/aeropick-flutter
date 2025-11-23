# 빌드 및 메모리 관리 가이드

## 문제 상황
AWS EC2 t2.micro (1GB RAM) 같은 낮은 메모리 환경에서 Gradle 빌드 시 메모리 부족으로 빌드가 실패하는 문제가 발생할 수 있습니다.

## 원인
- Gradle 데몬이 빌드 후에도 메모리를 계속 사용
- 여러 번 빌드 시 메모리가 누적되어 부족해짐
- 빌드 실패 반복 발생

## 해결 방법

### 1. Windows 환경

#### 방법 A: 자동 스크립트 사용 (권장)
```bash
# 프로젝트 루트에서 실행
build-and-clean.bat
```

#### 방법 B: 수동 실행
```bash
# 1. Flutter 빌드
flutter build apk

# 2. Gradle 데몬 중지 (필수!)
cd android
gradlew.bat --stop
cd ..
```

#### 방법 C: Android 디렉토리에서 직접 빌드
```bash
cd android
gradlew-build-and-stop.bat assembleDebug
```

### 2. Linux/Mac 환경

#### 방법 A: 자동 스크립트 사용 (권장)
```bash
# 실행 권한 부여 (최초 1회)
chmod +x build-and-clean.sh

# 프로젝트 루트에서 실행
./build-and-clean.sh
```

#### 방법 B: 수동 실행
```bash
# 1. Flutter 빌드
flutter build apk

# 2. Gradle 데몬 중지 (필수!)
cd android
./gradlew --stop
cd ..
```

#### 방법 C: Android 디렉토리에서 직접 빌드
```bash
cd android
chmod +x build-and-clean.sh
./build-and-clean.sh assembleDebug
```

### 3. Flutter 명령어 사용 시

Flutter는 내부적으로 Gradle을 사용하므로, 빌드 후 수동으로 데몬을 중지해야 합니다:

```bash
# Flutter 빌드
flutter build apk

# 또는
flutter run

# 빌드 후 반드시 실행
cd android
./gradlew --stop  # Linux/Mac
# 또는
gradlew.bat --stop  # Windows
cd ..
```

## 메모리 확인 방법

### Linux/Mac
```bash
free -h
```

### Windows (PowerShell)
```powershell
Get-CimInstance Win32_OperatingSystem | Select-Object FreePhysicalMemory, TotalVisibleMemorySize
```

## 권장 사항

1. **빌드 후 항상 데몬 중지**: 메모리 부족 방지
2. **정기적인 클린**: `flutter clean` 실행
3. **메모리 모니터링**: 빌드 전후 메모리 확인
4. **서버 재기동**: 메모리가 부족하면 서버 재기동

## 스크립트 파일 설명

- `build-and-clean.bat` / `build-and-clean.sh`: Flutter 빌드 + 자동 데몬 중지
- `android/gradlew-build-and-stop.bat`: Gradle 빌드 + 자동 데몬 중지
- `android/gradlew-clean.bat`: Gradle 클린 + 자동 데몬 중지

## 주의사항

- **빌드 후 반드시 데몬 중지**: 메모리 누수 방지
- **낮은 메모리 환경**: t2.micro 같은 환경에서는 필수
- **CI/CD 파이프라인**: 빌드 스크립트에 데몬 중지 추가 권장

