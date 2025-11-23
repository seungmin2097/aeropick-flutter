import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';
import 'flight_booking_calendar_screen.dart';

/// 가격으로 예매 화면
class PriceBookingScreen extends StatefulWidget {
  const PriceBookingScreen({super.key});

  @override
  State<PriceBookingScreen> createState() => _PriceBookingScreenState();
}

class _PriceBookingScreenState extends State<PriceBookingScreen> {
  bool _isRoundTrip = true;
  String? _departure;
  DateTime? _departureDate;
  DateTime? _returnDate;
  double _priceRange = 0.0; // 가격 범위 (0 ~ 500000)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroKColors.white,
      appBar: const AerokTopAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 브레드크럼
              Row(
                children: [
                  Text(
                    '예약',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AeroKColors.gray,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: AeroKColors.gray,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '항공권',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AeroKColors.gray,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: AeroKColors.gray,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '가격으로 예매',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AeroKColors.darkBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 제목
              Text(
                '가격으로 예매',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AeroKColors.darkBlue,
                ),
              ),
              const SizedBox(height: 24),
              // 왕복/편도 토글
              Container(
                height: 44,
                decoration: BoxDecoration(
                  color: AeroKColors.chartGray,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRoundTrip = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _isRoundTrip ? AeroKColors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: _isRoundTrip
                                ? Border.all(color: AeroKColors.darkBlue, width: 1)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              '왕복',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: _isRoundTrip
                                    ? AeroKColors.darkBlue
                                    : AeroKColors.gray,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRoundTrip = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: !_isRoundTrip ? AeroKColors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: !_isRoundTrip
                                ? Border.all(color: AeroKColors.darkBlue, width: 1)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              '편도',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: !_isRoundTrip
                                    ? AeroKColors.darkBlue
                                    : AeroKColors.gray,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // 출발지 및 날짜 입력 영역
              Row(
                children: [
                  // 출발지 입력 필드
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '출발지',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AeroKColors.gray,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _showLocationPicker(context),
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: AeroKColors.white,
                              border: Border.all(color: AeroKColors.lightGrayBg),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _departure ?? '출발지',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: _departure != null
                                          ? AeroKColors.darkBlue
                                          : AeroKColors.gray,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 날짜 입력 필드 (출발날짜~도착날짜)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '날짜',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AeroKColors.gray,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FlightBookingCalendarScreen(
                                  initialDeparture: _departureDate,
                                  initialReturn: _returnDate,
                                  isRoundTrip: _isRoundTrip,
                                ),
                              ),
                            );
                            if (result is Map<String, DateTime?>) {
                              setState(() {
                                _departureDate = result['departure'];
                                _returnDate = result['return'];
                              });
                            }
                          },
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: AeroKColors.white,
                              border: Border.all(color: AeroKColors.lightGrayBg),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _buildDateText(),
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: _departureDate != null
                                          ? AeroKColors.darkBlue
                                          : AeroKColors.gray,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                  color: AeroKColors.gray,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // 출발지와 날짜가 선택되면 가격 슬라이더 표시
              if (_departure != null && _departureDate != null) ...[
                const SizedBox(height: 40),
                _buildPriceSlider(),
              ],
              const SizedBox(height: 40),
              // 가격으로 검색 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // 가격으로 검색 기능 (추후 구현)
                    if (_departure == null || _departureDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('출발지와 날짜를 선택해주세요.'),
                        ),
                      );
                      return;
                    }
                    if (_isRoundTrip && _returnDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('도착 날짜를 선택해주세요.'),
                        ),
                      );
                      return;
                    }
                    // 검색 로직 추가
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AeroKColors.chartGray,
                    foregroundColor: AeroKColors.darkBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '가격으로 검색',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLocationPicker(BuildContext context) {
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
                const Text(
                  '출발지 선택',
                  style: TextStyle(
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

                      return ListTile(
                        title: Text(fullName),
                        onTap: () {
                          setState(() {
                            _departure = fullName;
                          });
                          Navigator.pop(context);
                        },
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

  String _buildDateText() {
    if (_departureDate == null) {
      return '날짜';
    }
    
    final depDate = '${_departureDate!.year}-${_departureDate!.month.toString().padLeft(2, '0')}-${_departureDate!.day.toString().padLeft(2, '0')}';
    
    if (_isRoundTrip && _returnDate != null) {
      final retDate = '${_returnDate!.year}-${_returnDate!.month.toString().padLeft(2, '0')}-${_returnDate!.day.toString().padLeft(2, '0')}';
      return '$depDate ~ $retDate';
    }
    
    return depDate;
  }

  Widget _buildPriceSlider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sliderWidth = constraints.maxWidth;
        final handlePosition = (_priceRange / 500000) * sliderWidth;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 슬라이더 영역
            SizedBox(
              height: 60,
              child: Stack(
                children: [
                  // 슬라이더 트랙
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 28,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: AeroKColors.chartGray,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  // 슬라이더 핸들 및 값 표시
                  Positioned(
                    left: (handlePosition - 12).clamp(0.0, sliderWidth - 24),
                    top: 0,
                    child: Column(
                      children: [
                        // 위쪽 큰 숫자
                        Text(
                          _priceRange.toInt().toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},',
                          ),
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // 슬라이더 핸들
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: AeroKColors.chartGray, width: 1),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // 아래쪽 작은 숫자
                        Text(
                          _priceRange.toInt().toString(),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 슬라이더 제스처 감지 영역
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        final localPosition = details.localPosition;
                        final newValue = (localPosition.dx / sliderWidth * 500000).clamp(0.0, 500000.0);
                        setState(() {
                          _priceRange = newValue;
                        });
                      },
                      onTapDown: (details) {
                        final localPosition = details.localPosition;
                        final newValue = (localPosition.dx / sliderWidth * 500000).clamp(0.0, 500000.0);
                        setState(() {
                          _priceRange = newValue;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // 최소값, 중간값, 최대값 표시
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
                // 중간 라벨 (120,000) - 약 1/4 지점
                Text(
                  '120,000',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '500,000',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

