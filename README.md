# 항공 예약 앱 (Airline App)

Flutter와 안드로이드 스튜디오를 이용한 항공 예약 애플리케이션입니다.

## 주요 기능

- 🏠 **홈 화면**: 인기 항공편 및 빠른 검색
- 🔍 **항공편 검색**: 출발지, 도착지, 날짜, 승객 수로 검색
- ✈️ **예약 관리**: 예약 내역 확인 및 취소
- 👤 **프로필**: 사용자 정보 및 설정

## 기술 스택

- **Flutter**: 크로스 플랫폼 UI 프레임워크
- **Provider**: 상태 관리
- **SharedPreferences**: 로컬 데이터 저장
- **Material Design 3**: 모던 UI 디자인

## 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점
├── models/                   # 데이터 모델
│   ├── flight.dart          # 항공편 모델
│   └── booking.dart         # 예약 모델
├── providers/               # 상태 관리
│   ├── flight_provider.dart # 항공편 상태
│   └── user_provider.dart   # 사용자 상태
├── screens/                 # 화면
│   ├── home_screen.dart     # 홈 화면
│   ├── search_screen.dart   # 검색 화면
│   ├── bookings_screen.dart # 예약 화면
│   └── profile_screen.dart  # 프로필 화면
└── widgets/                 # 재사용 가능한 위젯
    └── flight_card.dart     # 항공편 카드
```

## 설치 및 실행

### 1. Flutter 설치
```bash
# Flutter SDK 다운로드 및 설치
# https://flutter.dev/docs/get-started/install

# 환경 변수 설정
export PATH="$PATH:`pwd`/flutter/bin"
```

### 2. 프로젝트 실행
```bash
# 의존성 설치
flutter pub get

# 앱 실행
flutter run
```

### 3. 안드로이드 스튜디오에서 실행
1. 안드로이드 스튜디오 열기
2. 프로젝트 폴더 열기
3. Flutter 플러그인 설치 확인
4. 디바이스 연결 후 실행

## 주요 화면

### 홈 화면
- 인기 항공편 목록
- 빠른 검색 버튼
- 직관적인 네비게이션

### 검색 화면
- 출발지/도착지 입력
- 날짜 선택
- 승객 수 선택
- 실시간 검색 결과

### 예약 화면
- 예약 내역 목록
- 예약 상세 정보
- 예약 취소 기능

### 프로필 화면
- 사용자 정보
- 설정 옵션
- 로그인/로그아웃

## 개발 가이드

### 새로운 기능 추가
1. `models/`에 데이터 모델 추가
2. `providers/`에 상태 관리 로직 추가
3. `screens/`에 화면 구현
4. `widgets/`에 재사용 가능한 컴포넌트 추가

### API 연동
- `providers/`에서 HTTP 요청 처리
- 실제 항공사 API 연동 가능
- 에러 처리 및 로딩 상태 관리

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.



