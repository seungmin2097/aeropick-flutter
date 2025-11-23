import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  
  // 편의 getter
  String get name => _currentUser?.userName ?? '';
  String get email => _currentUser?.email ?? '';
  String get phone => _currentUser?.phone ?? '';
  int get userId => _currentUser?.userId ?? 0;
  int get stampPoints => _currentUser?.stampPoints ?? 0;

  Future<void> login(String email, String password) async {
    // 실제 로그인 로직 대신 더미 데이터
    await Future.delayed(const Duration(seconds: 1));
    
    final now = DateTime.now();
    _currentUser = User(
      userId: 1,
      email: email,
      userName: '홍길동',
      phone: '010-1234-5678',
      birthDate: DateTime(1990, 1, 1),
      createdAt: now,
      updatedAt: now,
      status: 'active',
      stampPoints: 100,
    );
    _isLoggedIn = true;
    
    // SharedPreferences에 로그인 상태 저장
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
    await prefs.setInt('userId', _currentUser!.userId);
    await prefs.setString('userName', _currentUser!.userName);
    await prefs.setString('phone', _currentUser!.phone ?? '');
    await prefs.setInt('stampPoints', _currentUser!.stampPoints);
    
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
    
    // SharedPreferences에서 로그인 상태 제거
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('email');
    await prefs.remove('userId');
    await prefs.remove('userName');
    await prefs.remove('phone');
    await prefs.remove('stampPoints');
    
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    
    if (isLoggedIn) {
      final now = DateTime.now();
      _currentUser = User(
        userId: prefs.getInt('userId') ?? 1,
        email: prefs.getString('email') ?? '',
        userName: prefs.getString('userName') ?? '',
        phone: prefs.getString('phone'),
        createdAt: now,
        updatedAt: now,
        status: 'active',
        stampPoints: prefs.getInt('stampPoints') ?? 0,
      );
      _isLoggedIn = true;
    }
    
    notifyListeners();
  }

  // 스탬프 포인트 추가
  void addStampPoints(int points) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        stampPoints: _currentUser!.stampPoints + points,
        updatedAt: DateTime.now(),
      );
      // SharedPreferences 업데이트
      SharedPreferences.getInstance().then((prefs) {
        prefs.setInt('stampPoints', _currentUser!.stampPoints);
      });
      notifyListeners();
    }
  }

  // 스탬프 포인트 사용
  bool useStampPoints(int points) {
    if (_currentUser != null && _currentUser!.stampPoints >= points) {
      _currentUser = _currentUser!.copyWith(
        stampPoints: _currentUser!.stampPoints - points,
        updatedAt: DateTime.now(),
      );
      // SharedPreferences 업데이트
      SharedPreferences.getInstance().then((prefs) {
        prefs.setInt('stampPoints', _currentUser!.stampPoints);
      });
      notifyListeners();
      return true;
    }
    return false;
  }

  // 사용자 정보 업데이트
  Future<void> updateUser({
    String? userName,
    String? phone,
    DateTime? birthDate,
  }) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        userName: userName ?? _currentUser!.userName,
        phone: phone ?? _currentUser!.phone,
        birthDate: birthDate ?? _currentUser!.birthDate,
        updatedAt: DateTime.now(),
      );
      
      final prefs = await SharedPreferences.getInstance();
      if (userName != null) await prefs.setString('userName', userName);
      if (phone != null) await prefs.setString('phone', phone);
      
      notifyListeners();
    }
  }
}

