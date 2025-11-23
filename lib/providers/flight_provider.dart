import 'package:flutter/foundation.dart';
import '../models/flight.dart';
import '../services/flight_api_service.dart';

class FlightProvider with ChangeNotifier {
  List<Flight> _flights = [];
  List<Flight> _searchResults = [];
  bool _isLoading = false;
  String _error = '';

  final FlightApiService _apiService = FlightApiService();

  List<Flight> get flights => _flights;
  List<Flight> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get error => _error;
  
  // 공항 목록 조회 (외부 접근용)
  Future<void> loadAirportCodes() async {
    await _apiService.loadAirportCodes();
  }
  
  // 항공사 목록 조회 (외부 접근용)
  Future<void> loadAirlineCodes() async {
    await _apiService.loadAirlineCodes();
  }

  // 더미 데이터로 초기화
  void initializeFlights() {
    final now = DateTime.now();
    _flights = [
      Flight(
        flightId: 1,
        flightNumber: 'KE001',
        departureAirportCode: 'ICN',
        arrivalAirportCode: 'NRT',
        departureDatetime: DateTime(now.year, now.month, now.day, 9, 0),
        arrivalDatetime: DateTime(now.year, now.month, now.day, 12, 30),
        flightStatus: 'scheduled',
        aircraftType: 'Boeing 777',
        createdAt: now,
        price: 450000,
      ),
      Flight(
        flightId: 2,
        flightNumber: 'OZ101',
        departureAirportCode: 'ICN',
        arrivalAirportCode: 'NRT',
        departureDatetime: DateTime(now.year, now.month, now.day, 14, 30),
        arrivalDatetime: DateTime(now.year, now.month, now.day, 18, 0),
        flightStatus: 'scheduled',
        aircraftType: 'Airbus A330',
        createdAt: now,
        price: 420000,
      ),
      Flight(
        flightId: 3,
        flightNumber: '7C201',
        departureAirportCode: 'ICN',
        arrivalAirportCode: 'PUS',
        departureDatetime: DateTime(now.year, now.month, now.day, 8, 0),
        arrivalDatetime: DateTime(now.year, now.month, now.day, 9, 30),
        flightStatus: 'scheduled',
        aircraftType: 'Boeing 737',
        createdAt: now,
        price: 89000,
      ),
      Flight(
        flightId: 4,
        flightNumber: 'LJ201',
        departureAirportCode: 'ICN',
        arrivalAirportCode: 'CJU',
        departureDatetime: DateTime(now.year, now.month, now.day, 10, 15),
        arrivalDatetime: DateTime(now.year, now.month, now.day, 11, 45),
        flightStatus: 'scheduled',
        aircraftType: 'Boeing 737',
        createdAt: now,
        price: 120000,
      ),
    ];
    notifyListeners();
  }

  /// 항공편 검색 (공공데이터포탈 API 사용)
  Future<void> searchFlights({
    required String departure,
    required String arrival,
    required String departureDate,
    int passengers = 1,
  }) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      // 도시명을 공항 코드로 변환
      final depAirportCode = _apiService.getAirportCode(departure) ?? departure.toUpperCase();
      final arrAirportCode = _apiService.getAirportCode(arrival) ?? arrival.toUpperCase();

      // 날짜 형식 변환 (YYYY-MM-DD -> YYYYMMDD)
      final formattedDate = departureDate.replaceAll('-', '');

      print('=== 항공편 검색 파라미터 ===');
      print('출발지: $departure -> $depAirportCode');
      print('도착지: $arrival -> $arrAirportCode');
      print('출발날짜: $departureDate -> $formattedDate');
      print('승객 수: $passengers');
      print('========================');

      // API 호출
      final flights = await _apiService.getFlightInfo(
        depAirportId: depAirportCode,
        arrAirportId: arrAirportCode,
        depPlandTime: formattedDate,
        numOfRows: 100,
      );

      _searchResults = flights;

      if (_searchResults.isEmpty) {
        _error = '검색 결과가 없습니다.';
      }
    } catch (e) {
      print('항공편 검색 오류: $e');
      _error = '검색 중 오류가 발생했습니다: $e';
      _searchResults = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    _searchResults = [];
    _error = '';
    notifyListeners();
  }

  Flight? getFlightById(String id) {
    try {
      final flightId = int.tryParse(id);
      if (flightId == null) return null;
      return _flights.firstWhere((flight) => flight.flightId == flightId);
    } catch (e) {
      return null;
    }
  }

  Flight? getFlightByFlightId(int flightId) {
    try {
      return _flights.firstWhere((flight) => flight.flightId == flightId);
    } catch (e) {
      return null;
    }
  }
}

