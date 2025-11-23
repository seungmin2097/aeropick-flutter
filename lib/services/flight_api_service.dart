import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/flight.dart';

/// 공공데이터포탈 국내항공 운항정보 API 서비스
class FlightApiService {
  // API 키 (실제 운영 시에는 환경 변수나 secure storage에 저장)
  static const String _apiKey = 'bc11a3a87493b231235484bb9191e63e8e2b9730599e3a2229d8d3148abf8333';
  
  // 공공데이터포탈 국내항공 운항정보 API 엔드포인트
  static const String _baseUrl = 'http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService';
  
  // 공항 코드 매핑 캐시 (도시명 -> ICAO 코드)
  Map<String, String>? _airportCodeCache;
  
  // 항공사 코드 매핑 캐시 (항공사명 -> 항공사 코드)
  Map<String, String>? _airlineCodeCache;
  
  /// 항공편 운항 정보 조회
  /// 
  /// [depAirportId] 출발공항ID (예: ICN, GMP, CJU, PUS)
  /// [arrAirportId] 도착공항ID
  /// [depPlandTime] 출발예정일시 (YYYYMMDD 형식)
  /// [airlineId] 항공사ID (선택사항, 전체 조회 시 null)
  /// [numOfRows] 한 페이지 결과 수 (기본값: 10)
  /// [pageNo] 페이지 번호 (기본값: 1)
  Future<List<Flight>> getFlightInfo({
    required String depAirportId,
    required String arrAirportId,
    required String depPlandTime,
    String? airlineId,
    int numOfRows = 100,
    int pageNo = 1,
  }) async {
    try {
      // URL 인코딩된 API 키
      final encodedApiKey = Uri.encodeComponent(_apiKey);
      
      // API 파라미터 로그
      print('API 파라미터:');
      print('  출발공항: $depAirportId');
      print('  도착공항: $arrAirportId');
      print('  출발날짜: $depPlandTime');
      
      // API 엔드포인트 구성
      final url = Uri.parse(
        '$_baseUrl/getFlightOpratInfoList?'
        'serviceKey=$encodedApiKey&'
        'pageNo=$pageNo&'
        'numOfRows=$numOfRows&'
        'depAirportId=$depAirportId&'
        'arrAirportId=$arrAirportId&'
        'depPlandTime=$depPlandTime'
        '${airlineId != null ? '&airlineId=$airlineId' : ''}&'
        '_type=json'
      );

      // HTTP GET 요청
      print('API 호출 URL: $url');
      final response = await http.get(url);
      
      print('API 응답 상태 코드: ${response.statusCode}');
      print('API 응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final jsonData = json.decode(utf8.decode(response.bodyBytes));
          print('파싱된 JSON 데이터: $jsonData');
          final flights = _parseFlightResponse(jsonData);
          print('파싱된 항공편 개수: ${flights.length}');
          return flights;
        } catch (e) {
          print('JSON 파싱 오류: $e');
          print('응답 본문: ${response.body}');
          throw Exception('응답 파싱 실패: $e');
        }
      } else {
        print('API 요청 실패: ${response.statusCode}, 본문: ${response.body}');
        throw Exception('API 요청 실패: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('항공편 정보 조회 중 오류: $e');
      throw Exception('항공편 정보 조회 중 오류 발생: $e');
    }
  }

  /// API 응답을 Flight 리스트로 변환
  List<Flight> _parseFlightResponse(Map<String, dynamic> jsonData) {
    final List<Flight> flights = [];

    try {
      print('응답 데이터 구조 확인: ${jsonData.keys}');
      
      // 공공데이터포탈 API 응답 구조 파싱
      final response = jsonData['response'];
      if (response == null) {
        print('response가 null입니다. 전체 데이터: $jsonData');
        return flights;
      }

      final body = response['body'];
      if (body == null) {
        print('body가 null입니다. response: $response');
        return flights;
      }

      // totalCount 확인
      final totalCount = body['totalCount'] ?? body['totalcount'] ?? 0;
      print('총 항공편 개수: $totalCount');

      // totalCount가 0이면 결과 없음
      if (totalCount == 0) {
        print('검색 결과가 없습니다 (totalCount: 0)');
        return flights;
      }

      final items = body['items'];
      if (items == null) {
        print('items가 null입니다. body: $body');
        return flights;
      }

      // items가 빈 문자열이거나 null인 경우
      if (items is String && items.isEmpty) {
        print('items가 빈 문자열입니다.');
        return flights;
      }

      // items가 Map이 아닌 경우 (빈 문자열 등)
      if (items is! Map) {
        print('items가 Map이 아닙니다. 타입: ${items.runtimeType}, 값: $items');
        return flights;
      }

      if (items['item'] == null) {
        print('item이 null입니다. items: $items');
        return flights;
      }

      // item이 단일 객체인 경우와 배열인 경우 처리
      final List<dynamic> itemList;
      if (items['item'] is List) {
        itemList = items['item'];
      } else {
        itemList = [items['item']];
      }

      int flightIdCounter = 1;
      for (var item in itemList) {
        try {
          final flight = _parseFlightItem(item, flightIdCounter++);
          if (flight != null) {
            flights.add(flight);
          }
        } catch (e) {
          // 개별 항목 파싱 실패 시 스킵
          continue;
        }
      }
    } catch (e) {
      throw Exception('응답 파싱 중 오류: $e');
    }

    return flights;
  }

  /// 개별 항공편 정보를 Flight 객체로 변환
  Flight? _parseFlightItem(Map<String, dynamic> item, int flightId) {
    try {
      // 공공데이터포탈 API 필드명 매핑 (명세서 기준)
      final flightNumber = item['vihicleId'] ?? item['vihicleid'] ?? '';
      final depAirportNm = item['depAirportNm'] ?? item['depairportnm'] ?? '';
      final arrAirportNm = item['arrAirportNm'] ?? item['arrairportnm'] ?? '';
      final depPlandTime = item['depPlandTime'] ?? item['depplandtime'] ?? '';
      final arrPlandTime = item['arrPlandTime'] ?? item['arrplandtime'] ?? '';
      final airlineNm = item['airlineNm'] ?? item['airlinenm'] ?? '';
      final economyCharge = item['economyCharge'] ?? item['economycharge'] ?? 0;
      final prestigeCharge = item['prestigeCharge'] ?? item['prestigecharge'] ?? 0;

      // 날짜/시간 파싱 (YYYYMMDDHHmm 형식)
      DateTime? departureDatetime;
      DateTime? arrivalDatetime;

      if (depPlandTime.isNotEmpty && depPlandTime.length >= 12) {
        try {
          final year = int.parse(depPlandTime.substring(0, 4));
          final month = int.parse(depPlandTime.substring(4, 6));
          final day = int.parse(depPlandTime.substring(6, 8));
          final hour = int.parse(depPlandTime.substring(8, 10));
          final minute = int.parse(depPlandTime.substring(10, 12));
          departureDatetime = DateTime(year, month, day, hour, minute);
        } catch (e) {
          // 파싱 실패 시 현재 시간 사용
          departureDatetime = DateTime.now();
        }
      } else {
        departureDatetime = DateTime.now();
      }

      if (arrPlandTime.isNotEmpty && arrPlandTime.length >= 12) {
        try {
          final year = int.parse(arrPlandTime.substring(0, 4));
          final month = int.parse(arrPlandTime.substring(4, 6));
          final day = int.parse(arrPlandTime.substring(6, 8));
          final hour = int.parse(arrPlandTime.substring(8, 10));
          final minute = int.parse(arrPlandTime.substring(10, 12));
          arrivalDatetime = DateTime(year, month, day, hour, minute);
        } catch (e) {
          // 파싱 실패 시 출발 시간 + 2시간
          arrivalDatetime = departureDatetime.add(const Duration(hours: 2));
        }
      } else {
        arrivalDatetime = departureDatetime.add(const Duration(hours: 2));
      }

      // 가격 정보 (일반석 기준, 없으면 0)
      double price = 0;
      if (economyCharge != null && economyCharge != 0) {
        price = (economyCharge is int) ? economyCharge.toDouble() : economyCharge;
      } else if (prestigeCharge != null && prestigeCharge != 0) {
        price = (prestigeCharge is int) ? prestigeCharge.toDouble() : prestigeCharge;
      }

      // 공항명을 코드로 변환 (공항명이 오는 경우)
      String depCode = depAirportNm;
      String arrCode = arrAirportNm;
      
      // 공항명이 한글이면 코드로 변환 시도
      final airportCodeMap = {
        '인천': 'ICN',
        '서울': 'GMP',
        '김포': 'GMP',
        '제주': 'CJU',
        '부산': 'PUS',
        '김해': 'PUS',
        '대구': 'TAE',
        '광주': 'KWJ',
        '여수': 'RSU',
        '원주': 'WJU',
        '양양': 'YNY',
      };
      
      depCode = airportCodeMap[depAirportNm] ?? depAirportNm;
      arrCode = airportCodeMap[arrAirportNm] ?? arrAirportNm;

      return Flight(
        flightId: flightId,
        flightNumber: flightNumber,
        departureAirportCode: depCode,
        arrivalAirportCode: arrCode,
        departureDatetime: departureDatetime,
        arrivalDatetime: arrivalDatetime,
        flightStatus: 'scheduled',
        aircraftType: '', // API에서 제공하지 않을 수 있음
        createdAt: DateTime.now(),
        price: price,
      );
    } catch (e) {
      return null;
    }
  }

  /// 공항 목록 조회 (공항 코드 매핑용)
  Future<Map<String, String>> getAirportList() async {
    try {
      final encodedApiKey = Uri.encodeComponent(_apiKey);
      final url = Uri.parse(
        '$_baseUrl/getArprtList?'
        'serviceKey=$encodedApiKey&'
        '_type=json'
      );

      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        final Map<String, String> airportMap = {};
        
        try {
          final items = jsonData['response']?['body']?['items'];
          if (items != null && items['item'] != null) {
            final List<dynamic> itemList;
            if (items['item'] is List) {
              itemList = items['item'];
            } else {
              itemList = [items['item']];
            }
            
            for (var item in itemList) {
              final airportId = item['airportId'] ?? item['airportid'] ?? '';
              final airportNm = item['airportNm'] ?? item['airportnm'] ?? '';
              if (airportId.isNotEmpty && airportNm.isNotEmpty) {
                airportMap[airportNm] = airportId;
              }
            }
          }
        } catch (e) {
          print('공항 목록 파싱 오류: $e');
        }
        
        return airportMap;
      }
    } catch (e) {
      print('공항 목록 조회 오류: $e');
    }
    
    // 폴백: 기본 공항 코드 매핑 (ICAO 형식)
    return {
      '인천': 'NAARKJJ',  // 인천국제공항
      '서울': 'NAARKSS',  // 김포공항
      '제주': 'NAARKPC',  // 제주공항
      '부산': 'NAARKPK',  // 김해공항
      '김해': 'NAARKPK',  // 김해공항
      '대구': 'NAARKTN',  // 대구공항
      '광주': 'NAARKJJ',  // 광주공항 (예시, 실제 코드 확인 필요)
      '여수': 'NAARKRSU', // 여수공항
      '원주': 'NAARKWJU', // 원주공항
      '양양': 'NAARKYNY', // 양양공항
    };
  }

  /// 공항 코드 변환 (도시명 -> ICAO 공항 코드)
  /// 명세서 예제 기준: NAARKJJ(광주), NAARKPC(제주)
  /// 주의: 인천국제공항은 NAARKICN 또는 다른 코드일 수 있음
  String? getAirportCode(String cityName) {
    // 캐시된 공항 코드 매핑이 있으면 사용
    if (_airportCodeCache != null && _airportCodeCache!.containsKey(cityName)) {
      final code = _airportCodeCache![cityName]!;
      print('공항 코드 변환 (캐시): "$cityName" -> "$code"');
      return code;
    }
    
    // 기본 매핑 (ICAO 코드 형식)
    // 정확한 매핑은 getAirportList() API로 확인 가능
    // 명세서 예제: NAARKJJ=광주, NAARKPC=제주
    final airportMap = {
      '인천': 'NAARKICN',  // 인천국제공항 (추정, 실제 코드 확인 필요)
      '서울': 'NAARKSS',   // 김포공항
      '제주': 'NAARKPC',   // 제주공항 (명세서 예제 확인됨)
      '부산': 'NAARKPK',   // 김해공항
      '김해': 'NAARKPK',   // 김해공항
      '대구': 'NAARKTN',   // 대구공항
      '광주': 'NAARKJJ',   // 광주공항 (명세서 예제 확인됨)
      '여수': 'NAARKRSU',  // 여수공항
      '원주': 'NAARKWJU',  // 원주공항
      '양양': 'NAARKYNY',  // 양양공항
    };
    final code = airportMap[cityName] ?? cityName;
    print('공항 코드 변환: "$cityName" -> "$code"');
    return code;
  }
  
  /// 공항 목록 조회 및 캐시 업데이트
  Future<void> loadAirportCodes() async {
    try {
      print('공항 목록 조회 시작...');
      final airportMap = await getAirportList();
      _airportCodeCache = airportMap;
      print('공항 목록 조회 완료: ${airportMap.length}개 공항');
      print('공항 코드 매핑: $airportMap');
    } catch (e) {
      print('공항 목록 조회 실패: $e');
    }
  }
  
  /// 항공사 목록 조회 및 캐시 업데이트
  Future<void> loadAirlineCodes() async {
    try {
      print('항공사 목록 조회 시작...');
      final airlineMap = await getAirlineList();
      _airlineCodeCache = airlineMap;
      print('항공사 목록 조회 완료: ${airlineMap.length}개 항공사');
      print('항공사 코드 매핑: $airlineMap');
    } catch (e) {
      print('항공사 목록 조회 실패: $e');
    }
  }

  /// 항공사 목록 조회 (공항 코드 매핑용)
  Future<Map<String, String>> getAirlineList() async {
    try {
      final encodedApiKey = Uri.encodeComponent(_apiKey);
      final url = Uri.parse(
        '$_baseUrl/getAirmanList?'
        'serviceKey=$encodedApiKey&'
        '_type=json'
      );

      print('항공사 목록 조회 API 호출: $url');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        final Map<String, String> airlineMap = {};
        
        try {
          final items = jsonData['response']?['body']?['items'];
          if (items != null && items['item'] != null) {
            final List<dynamic> itemList;
            if (items['item'] is List) {
              itemList = items['item'];
            } else {
              itemList = [items['item']];
            }
            
            for (var item in itemList) {
              final airlineId = item['airlineId'] ?? item['airlineid'] ?? '';
              final airlineNm = item['airlineNm'] ?? item['airlinenm'] ?? '';
              if (airlineId.isNotEmpty && airlineNm.isNotEmpty) {
                airlineMap[airlineNm] = airlineId;
              }
            }
          }
          print('항공사 목록 조회 완료: ${airlineMap.length}개 항공사');
          print('항공사 목록: $airlineMap');
        } catch (e) {
          print('항공사 목록 파싱 오류: $e');
        }
        
        return airlineMap;
      }
    } catch (e) {
      print('항공사 목록 조회 오류: $e');
    }
    
    // 폴백: 기본 항공사 코드 매핑
    return {
      '대한항공': 'AAR',
      '아시아나항공': 'AAR',
      '제주항공': 'JJA',
      '진에어': 'JNA',
      '에어부산': 'ABL',
      '티웨이항공': 'TWB',
    };
  }

  /// 항공사 코드 변환 (항공사명 -> 항공사 코드)
  String? getAirlineCode(String airlineName) {
    // 캐시된 항공사 코드 매핑이 있으면 사용
    if (_airlineCodeCache != null && _airlineCodeCache!.containsKey(airlineName)) {
      final code = _airlineCodeCache![airlineName]!;
      print('항공사 코드 변환 (캐시): "$airlineName" -> "$code"');
      return code;
    }
    
    // 기본 매핑
    final airlineMap = {
      '대한항공': 'AAR',
      '아시아나항공': 'AAR',
      '제주항공': 'JJA',
      '진에어': 'JNA',
      '에어부산': 'ABL',
      '티웨이항공': 'TWB',
    };
    final code = airlineMap[airlineName];
    print('항공사 코드 변환: "$airlineName" -> "$code"');
    return code;
  }
}

