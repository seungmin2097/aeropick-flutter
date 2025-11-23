import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/hero_section.dart';
import '../widgets/promotion_carousel_banner.dart';
import '../widgets/promotion_events_section.dart';
import '../widgets/lowest_price_module.dart';
import '../widgets/aerok_top_app_bar.dart';
import '../theme/aerok_colors.dart';
import 'search_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isRoundTrip = true;
  String? _departure;
  String? _arrival;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FlightProvider>().initializeFlights();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroKColors.darkBlue, // 전체 배경을 어두운 파란색으로
      drawer: const AppDrawer(),
      appBar: const AerokTopAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          color: AeroKColors.darkBlue,
        ),
        child: SingleChildScrollView(
        child: Column(
          children: [
            // 히어로 섹션 (검색 위젯 포함)
            HeroSection(
              isRoundTrip: _isRoundTrip,
              onTripTypeChanged: (value) {
                setState(() {
                  _isRoundTrip = value;
                });
              },
              departure: _departure,
              arrival: _arrival,
              onDepartureTap: () {
                _showLocationPicker(context, true);
              },
              onArrivalTap: () {
                _showLocationPicker(context, false);
              },
              onSwapTap: () {
                setState(() {
                  final temp = _departure;
                  _departure = _arrival;
                  _arrival = temp;
                });
              },
              onSearchTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // 프로모션 캐러셀 배너
            const PromotionCarouselBanner(),
            const SizedBox(height: 30),
            // 최저가 확인 모듈
            const LowestPriceModule(),
            const SizedBox(height: 30),
            // 프로모션 이벤트 섹션
            const PromotionEventsSection(),
            const SizedBox(height: 30),
          ],
        ),
        ),
      ),
    );
  }

  // 출발지별 가능한 도착지 목록
  List<String> _getAvailableDestinations(String? departure) {
    if (departure == null) return [];
    
    final depCode = departure.split(' ').last;
    
    switch (depCode) {
      case 'CJJ': // 청주 - 서울/인천, 화롄 제외하고 모두 가능
        return []; // 빈 리스트는 모든 목적지 가능을 의미 (제외 목록은 별도 처리)
      case 'CJU': // 제주
        return ['청주 CJJ', '히로시마 HIJ'];
      case 'ICN': // 서울/인천
        return ['이바라키 IBR', '오사카/간사이 KIX', '오비히로 OBO'];
      case 'NRT': // 도쿄/나리타
        return ['청주 CJJ'];
      case 'IBR': // 이바라키
        return ['청주 CJJ', '서울/인천 ICN'];
      case 'KIX': // 오사카/간사이
        return ['청주 CJJ', '서울/인천 ICN'];
      case 'CTS': // 삿포로/신치토세
        return ['청주 CJJ'];
      case 'OBO': // 오비히로
        return ['청주 CJJ', '서울/인천 ICN'];
      case 'FUK': // 후쿠오카
        return ['청주 CJJ'];
      case 'KKJ': // 기타큐슈
        return ['청주 CJJ'];
      case 'HIJ': // 히로시마
        return ['청주 CJJ', '제주 CJU'];
      case 'OKA': // 오키나와
        return ['청주 CJJ'];
      case 'NGO': // 나고야
        return ['청주 CJJ'];
      case 'TPE': // 타이베이/타오위안
        return ['청주 CJJ'];
      case 'HUN': // 화롄
        return ['서울/인천 ICN'];
      case 'RMQ': // 타이중
        return ['청주 CJJ'];
      case 'TAO': // 칭다오
        return ['청주 CJJ'];
      case 'CEB': // 세부
        return ['청주 CJJ'];
      case 'DAD': // 다낭
        return ['청주 CJJ'];
      case 'CXR': // 나트랑
        return ['청주 CJJ'];
      case 'CRK': // 클락
        return ['청주 CJJ'];
      default:
        return []; // 기본적으로 모든 목적지 가능 (또는 빈 리스트)
    }
  }

  void _showLocationPicker(BuildContext context, bool isDeparture) {
    // 지역별 여행지 목록
    final locationGroups = [
      {
        'region': '대한민국',
        'locations': [
          {'name': '청주', 'code': 'CJJ'},
          {'name': '제주', 'code': 'CJU'},
          {'name': '서울/인천', 'code': 'ICN'},
        ],
      },
      {
        'region': '일본',
        'locations': [
          {'name': '도쿄/나리타', 'code': 'NRT'},
          {'name': '이바라키', 'code': 'IBR'},
          {'name': '오사카/간사이', 'code': 'KIX'},
          {'name': '삿포로/신치토세', 'code': 'CTS'},
          {'name': '오비히로', 'code': 'OBO'},
          {'name': '후쿠오카', 'code': 'FUK'},
          {'name': '기타큐슈', 'code': 'KKJ'},
          {'name': '히로시마', 'code': 'HIJ'},
          {'name': '오키나와', 'code': 'OKA'},
          {'name': '나고야', 'code': 'NGO'},
        ],
      },
      {
        'region': '동북아시아',
        'locations': [
          {'name': '타이베이/타오위안', 'code': 'TPE'},
          {'name': '화롄', 'code': 'HUN'},
          {'name': '타이중', 'code': 'RMQ'},
          {'name': '칭다오', 'code': 'TAO'},
        ],
      },
      {
        'region': '동남아시아',
        'locations': [
          {'name': '세부', 'code': 'CEB'},
          {'name': '다낭', 'code': 'DAD'},
          {'name': '나트랑', 'code': 'CXR'},
          {'name': '클락', 'code': 'CRK'},
        ],
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 헤더
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDeparture ? '출발지 선택' : '도착지 선택',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 지역별 확장 가능한 리스트
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: locationGroups.length,
                itemBuilder: (context, groupIndex) {
                  final group = locationGroups[groupIndex];
                  final region = group['region'] as String;
                  final locations = group['locations'] as List<Map<String, String>>;
                  
                  return ExpansionTile(
                    title: Text(
                      region,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: locations.map((location) {
                      final locationName = location['name']!;
                      final locationCode = location['code']!;
                      final fullName = '$locationName $locationCode';

                      // 출발지 선택 시: 도착지와 같으면 선택 불가
                      // 도착지 선택 시: 출발지와 같으면 선택 불가 + 출발지에서 갈 수 없는 곳이면 선택 불가
                      bool isDisabled = false;
                      if (isDeparture) {
                        isDisabled = (fullName == _arrival);
                      } else {
                        isDisabled = (fullName == _departure);
                        // 도착지 선택 시, 출발지가 선택되어 있으면 가능한 도착지만 허용
                        if (!isDisabled && _departure != null) {
                          final departureCode = _departure!.split(' ').last;
                          
                          // 청주(CJJ)의 경우: 서울/인천(ICN), 화롄(HUN) 제외하고 모두 가능
                          if (departureCode == 'CJJ') {
                            if (locationCode == 'ICN' || locationCode == 'HUN') {
                              isDisabled = true;
                            }
                          } else {
                            // 다른 출발지의 경우 기존 로직 사용
                            final availableDestinations = _getAvailableDestinations(_departure);
                            if (availableDestinations.isNotEmpty) {
                              isDisabled = !availableDestinations.contains(fullName);
                            }
                          }
                        }
                      }

                      return ListTile(
                        title: Text(fullName),
                        enabled: !isDisabled,
                        onTap: isDisabled
                            ? null
                            : () {
                                setState(() {
                                  if (isDeparture) {
                                    _departure = fullName;
                                    // 출발지 변경 시 도착지가 불가능하면 초기화
                                    if (_arrival != null) {
                                      final newDepCode = fullName.split(' ').last;
                                      
                                      // 청주(CJJ)의 경우: 서울/인천(ICN), 화롄(HUN) 제외하고 모두 가능
                                      if (newDepCode == 'CJJ') {
                                        final arrCode = _arrival!.split(' ').last;
                                        if (arrCode == 'ICN' || arrCode == 'HUN') {
                                          _arrival = null;
                                        }
                                      } else {
                                        // 다른 출발지의 경우 기존 로직 사용
                                        final availableDestinations = _getAvailableDestinations(fullName);
                                        if (availableDestinations.isNotEmpty && 
                                            !availableDestinations.contains(_arrival!)) {
                                          _arrival = null;
                                        }
                                      }
                                    }
                                  } else {
                                    _arrival = fullName;
                                  }
                                });
                                Navigator.pop(context);
                              },
                        trailing: isDisabled
                            ? const Icon(Icons.block, color: Colors.grey)
                            : null,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

