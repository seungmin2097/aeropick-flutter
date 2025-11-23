import 'package:flutter/foundation.dart';
import '../models/stamp_location.dart';
import '../models/user_stamp.dart';

class StampProvider with ChangeNotifier {
  List<StampLocation> _locations = [];
  List<UserStamp> _userStamps = [];
  int _nextLocationId = 1;
  int _nextUserStampId = 1;

  List<StampLocation> get locations => _locations;
  List<UserStamp> get userStamps => _userStamps;

  // 초기화 - 더미 스탬프 위치 생성
  void initializeLocations() {
    _locations = [
      StampLocation(
        stampLocationId: _nextLocationId++,
        locationName: '더미 위치 1',
        locationDesc: '테스트용 스탬프 위치 1',
        qrCodeValue: 'STAMP_001',
      ),
      StampLocation(
        stampLocationId: _nextLocationId++,
        locationName: '더미 위치 2',
        locationDesc: '테스트용 스탬프 위치 2',
        qrCodeValue: 'STAMP_002',
      ),
      StampLocation(
        stampLocationId: _nextLocationId++,
        locationName: '더미 위치 3',
        locationDesc: '테스트용 스탬프 위치 3',
        qrCodeValue: 'STAMP_003',
      ),
      StampLocation(
        stampLocationId: _nextLocationId++,
        locationName: '더미 위치 4',
        locationDesc: '테스트용 스탬프 위치 4',
        qrCodeValue: 'STAMP_004',
      ),
      StampLocation(
        stampLocationId: _nextLocationId++,
        locationName: '더미 위치 5',
        locationDesc: '테스트용 스탬프 위치 5',
        qrCodeValue: 'STAMP_005',
      ),
      StampLocation(
        stampLocationId: _nextLocationId++,
        locationName: '더미 위치 6',
        locationDesc: '테스트용 스탬프 위치 6',
        qrCodeValue: 'STAMP_006',
      ),
      StampLocation(
        stampLocationId: _nextLocationId++,
        locationName: '더미 위치 7',
        locationDesc: '테스트용 스탬프 위치 7',
        qrCodeValue: 'STAMP_007',
      ),
      StampLocation(
        stampLocationId: _nextLocationId++,
        locationName: '더미 위치 8',
        locationDesc: '테스트용 스탬프 위치 8',
        qrCodeValue: 'STAMP_008',
      ),
      StampLocation(
        stampLocationId: _nextLocationId++,
        locationName: '더미 위치 9',
        locationDesc: '테스트용 스탬프 위치 9',
        qrCodeValue: 'STAMP_009',
      ),
      StampLocation(
        stampLocationId: _nextLocationId++,
        locationName: '더미 위치 10',
        locationDesc: '테스트용 스탬프 위치 10',
        qrCodeValue: 'STAMP_010',
      ),
    ];
    notifyListeners();
  }

  // QR 코드로 위치 찾기
  StampLocation? getLocationByQrCode(String qrCode) {
    try {
      return _locations.firstWhere((loc) => loc.qrCodeValue == qrCode);
    } catch (e) {
      return null;
    }
  }

  // 사용자별 스탬프 조회
  List<UserStamp> getUserStampsByUserId(int userId) {
    return _userStamps.where((stamp) => stamp.fkUserId == userId).toList();
  }

  // 스탬프 추가 (QR 코드 스캔)
  Future<UserStamp?> scanStamp({
    required int userId,
    required String qrCode,
  }) async {
    final location = getLocationByQrCode(qrCode);
    if (location == null) {
      return null; // 유효하지 않은 QR 코드
    }

    // 이미 스캔한 위치인지 확인
    final existingStamp = _userStamps.firstWhere(
      (stamp) =>
          stamp.fkUserId == userId &&
          stamp.fkStampLocationId == location.stampLocationId,
      orElse: () => UserStamp(
        userStampId: 0,
        fkUserId: 0,
        fkStampLocationId: 0,
        scannedAt: DateTime.now(),
      ),
    );

    if (existingStamp.userStampId != 0) {
      return null; // 이미 스캔한 위치
    }

    // 새 스탬프 추가
    final userStamp = UserStamp(
      userStampId: _nextUserStampId++,
      fkUserId: userId,
      fkStampLocationId: location.stampLocationId,
      scannedAt: DateTime.now(),
    );
    _userStamps.add(userStamp);
    notifyListeners();

    return userStamp;
  }

  // 사용자가 특정 위치를 스캔했는지 확인
  bool hasUserScannedLocation(int userId, int locationId) {
    return _userStamps.any(
      (stamp) => stamp.fkUserId == userId && stamp.fkStampLocationId == locationId,
    );
  }
}



