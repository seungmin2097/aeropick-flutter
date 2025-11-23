import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';
import 'flight_booking_calendar_screen.dart';
import 'main_screen.dart';

/// 운항 정보 화면
class FlightInfoScreen extends StatefulWidget {
  const FlightInfoScreen({super.key});

  @override
  State<FlightInfoScreen> createState() => _FlightInfoScreenState();
}

class _FlightInfoScreenState extends State<FlightInfoScreen> {
  bool _isScheduleInquiry = true; // true: 스케줄 조회, false: 출도착 조회
  bool _isRoundTrip = true;
  String? _departure;
  String? _arrival;
  DateTime? _departureDate;
  DateTime? _returnDate;
  bool _hasSearched = false; // 조회 여부
  bool _selectedDirection = true; // true: 출발->도착, false: 도착->출발
  bool _isRouteSearch = true; // true: 노선, false: 편명 (출도착 조회용)
  String? _flightNumber; // 편명 (출도착 조회용)

  @override
  void initState() {
    super.initState();
    _departure = '출발';
    _arrival = '도착';
    _departureDate = null;
    _returnDate = null;
  }

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
              // 탭
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isScheduleInquiry = true;
                          _hasSearched = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _isScheduleInquiry ? AeroKColors.darkBlue : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          '스케줄 조회',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _isScheduleInquiry ? AeroKColors.darkBlue : AeroKColors.gray,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isScheduleInquiry = false;
                          _hasSearched = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: !_isScheduleInquiry ? AeroKColors.darkBlue : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          '출도착 조회',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: !_isScheduleInquiry ? AeroKColors.darkBlue : AeroKColors.gray,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 스케줄 조회일 때: 왕복/편도 선택
              if (_isScheduleInquiry) ...[
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRoundTrip = true;
                          });
                        },
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: _isRoundTrip ? AeroKColors.white : AeroKColors.lightGrayBg,
                            border: Border.all(
                              color: _isRoundTrip ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '왕복',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _isRoundTrip ? AeroKColors.darkBlue : AeroKColors.gray,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRoundTrip = false;
                          });
                        },
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: !_isRoundTrip ? AeroKColors.white : AeroKColors.lightGrayBg,
                            border: Border.all(
                              color: !_isRoundTrip ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '편도',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: !_isRoundTrip ? AeroKColors.darkBlue : AeroKColors.gray,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
              // 출도착 조회일 때: 노선/편명 선택
              if (!_isScheduleInquiry) ...[
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRouteSearch = true;
                            _hasSearched = false;
                          });
                        },
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: _isRouteSearch ? AeroKColors.white : AeroKColors.lightGrayBg,
                            border: Border.all(
                              color: _isRouteSearch ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '노선',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _isRouteSearch ? AeroKColors.darkBlue : AeroKColors.gray,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isRouteSearch = false;
                            _hasSearched = false;
                          });
                        },
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: !_isRouteSearch ? AeroKColors.white : AeroKColors.lightGrayBg,
                            border: Border.all(
                              color: !_isRouteSearch ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '편명',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: !_isRouteSearch ? AeroKColors.darkBlue : AeroKColors.gray,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
              // 출발지/도착지 및 날짜 선택 영역
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 출발지/도착지 (스케줄 조회 또는 출도착 조회의 노선 검색일 때)
                  if (_isScheduleInquiry || (_isRouteSearch && !_isScheduleInquiry)) ...[
                    Row(
                      children: [
                        // 출발지
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _showLocationPicker(context, true),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AeroKColors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: _buildLocationText(_departure, true),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // 스왑 버튼
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              final temp = _departure;
                              _departure = _arrival;
                              _arrival = temp;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AeroKColors.lightGrayBg,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.swap_horiz,
                              color: AeroKColors.darkBlue,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // 도착지
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _showLocationPicker(context, false),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AeroKColors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: _buildLocationText(_arrival, false),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  // 편명 입력 (출도착 조회의 편명 검색일 때)
                  if (!_isScheduleInquiry && !_isRouteSearch) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AeroKColors.white,
                        border: Border.all(color: AeroKColors.lightGrayBg),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _flightNumber = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '편명 입력 (예: RF392)',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: AeroKColors.gray,
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: AeroKColors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  // 날짜 및 조회 버튼
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 날짜 레이블
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
                      // 날짜 입력 필드
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
                              // 날짜가 변경되면 자동으로 새로운 랜덤 스케줄이 생성됨
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AeroKColors.white,
                            border: Border.all(color: AeroKColors.lightGrayBg),
                            borderRadius: BorderRadius.circular(8),
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
                                    color: AeroKColors.black,
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
                      const SizedBox(height: 16),
                      // 조회 버튼
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_isScheduleInquiry) {
                              // 스케줄 조회
                              if (_departure == null || _arrival == null || _departureDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('출발지, 도착지, 날짜를 모두 선택해주세요.'),
                                  ),
                                );
                                return;
                              }
                              setState(() {
                                _hasSearched = true;
                                _selectedDirection = true;
                              });
                            } else {
                              // 출도착 조회
                              if (_isRouteSearch) {
                                if (_departure == null || _arrival == null || _departureDate == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('출발지, 도착지, 날짜를 모두 선택해주세요.'),
                                    ),
                                  );
                                  return;
                                }
                              } else {
                                if (_flightNumber == null || _flightNumber!.isEmpty || _departureDate == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('편명과 날짜를 입력해주세요.'),
                                    ),
                                  );
                                  return;
                                }
                              }
                              setState(() {
                                _hasSearched = true;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AeroKColors.darkBlue,
                            foregroundColor: AeroKColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            '조회',
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
                ],
              ),
              // 조회 결과 표시
              if (_hasSearched) ...[
                const SizedBox(height: 32),
                if (_isScheduleInquiry)
                  _buildScheduleResult()
                else
                  _buildDepartureArrivalResult(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleResult() {
    final depCode = _departure?.split(' ').first ?? 'CJU';
    final depName = _departure?.split(' ').last ?? '제주';
    final arrCode = _arrival?.split(' ').first ?? 'CJJ';
    final arrName = _arrival?.split(' ').last ?? '청주';

    // 선택된 날짜 기준으로 7일간의 날짜 리스트 생성
    final baseDate = _departureDate ?? DateTime.now();
    final dates = List.generate(7, (index) => baseDate.add(Duration(days: index)));

    // 더미 스케줄 데이터
    final schedules = _getDummySchedules(depCode, arrCode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 방향 탭
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDirection = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _selectedDirection ? AeroKColors.white : AeroKColors.lightGrayBg,
                    border: Border.all(
                      color: _selectedDirection ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                      width: _selectedDirection ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$depCode $depName → $arrCode $arrName',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _selectedDirection ? AeroKColors.darkBlue : AeroKColors.gray,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            if (_isRoundTrip)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDirection = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: !_selectedDirection ? AeroKColors.white : AeroKColors.lightGrayBg,
                      border: Border.all(
                        color: !_selectedDirection ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                        width: !_selectedDirection ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$arrCode $arrName → $depCode $depName',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: !_selectedDirection ? AeroKColors.darkBlue : AeroKColors.gray,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 24),
        // 스케줄 테이블
        _buildScheduleTable(schedules, dates, _selectedDirection ? depCode : arrCode, _selectedDirection ? arrCode : depCode),
        const SizedBox(height: 24),
        // 항공권 예매 버튼
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // 하단 메뉴의 항공권 예매 화면으로 이동
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainScreen(initialIndex: 1),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AeroKColors.darkBlue,
              foregroundColor: AeroKColors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              '항공권 예매',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleTable(List<Map<String, dynamic>> schedules, List<DateTime> dates, String depCode, String arrCode) {
    final flightInfoWidth = 200.0;
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AeroKColors.lightGrayBg),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더 행 (날짜)
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AeroKColors.lightGrayBg, width: 1),
              ),
            ),
            child: Row(
              children: [
                // 왼쪽 고정 열 (항공편 정보)
                SizedBox(
                  width: flightInfoWidth,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: AeroKColors.lightGrayBg, width: 1),
                      ),
                    ),
                    child: Text(
                      '항공편',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AeroKColors.gray,
                      ),
                    ),
                  ),
                ),
                // 날짜 열들
                ...dates.asMap().entries.map((entry) {
                  final index = entry.key;
                  final date = entry.value;
                  final isSelected = _departureDate != null &&
                      date.year == _departureDate!.year &&
                      date.month == _departureDate!.month &&
                      date.day == _departureDate!.day;
                  final isLast = index == dates.length - 1;
                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? AeroKColors.lightGrayBg.withOpacity(0.5) : Colors.transparent,
                        border: isLast ? null : Border(
                          right: BorderSide(color: AeroKColors.lightGrayBg, width: 1),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AeroKColors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getDayOfWeek(date.weekday),
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AeroKColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          // 스케줄 행들
          ...schedules.map((schedule) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AeroKColors.lightGrayBg, width: 1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 왼쪽 고정 열 (항공편 정보)
                  SizedBox(
                    width: flightInfoWidth,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: AeroKColors.lightGrayBg, width: 1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schedule['departureTime'],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AeroKColors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.flight,
                                size: 12,
                                color: AeroKColors.darkBlue,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                schedule['duration'],
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AeroKColors.gray,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            schedule['flightNumber'],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AeroKColors.gray,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            schedule['arrivalTime'],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AeroKColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 날짜별 가용성 셀들
                  ...dates.asMap().entries.map((entry) {
                    final index = entry.key;
                    final date = entry.value;
                    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                    final isAvailable = schedule['availableDates']?.contains(dateStr) ?? false;
                    final isLast = index == dates.length - 1;
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: isLast ? null : Border(
                            right: BorderSide(color: AeroKColors.lightGrayBg, width: 1),
                          ),
                        ),
                        child: Center(
                          child: isAvailable
                              ? Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                  color: AeroKColors.darkBlue,
                                )
                              : Text(
                                  '-',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AeroKColors.gray,
                                  ),
                                ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getDummySchedules(String depCode, String arrCode) {
    // 더미 스케줄 데이터 생성 (랜덤)
    final baseDate = _departureDate ?? DateTime.now();
    final random = Random(baseDate.millisecondsSinceEpoch); // 날짜를 시드로 사용하여 랜덤 생성
    
    // 출발 시간 옵션들
    final departureTimes = [
      {'time': '07:10', 'duration': '1시간 10분'},
      {'time': '07:10', 'duration': '1시간 15분'},
      {'time': '08:00', 'duration': '1시간 10분'},
      {'time': '12:55', 'duration': '1시간 15분'},
      {'time': '14:55', 'duration': '1시간 10분'},
      {'time': '20:30', 'duration': '1시간 10분'},
    ];
    
    // 항공편 번호 옵션들
    final flightNumbers = ['RF601', 'RF609', 'RF613', 'RF615', 'RF621', 'RF625'];
    
    // 랜덤하게 4-6개의 항공편 생성
    final scheduleCount = 4 + random.nextInt(3); // 4~6개
    final schedules = <Map<String, dynamic>>[];
    
    for (int i = 0; i < scheduleCount; i++) {
      final depTimeInfo = departureTimes[random.nextInt(departureTimes.length)];
      final depTime = depTimeInfo['time']!;
      final duration = depTimeInfo['duration']!;
      
      // 출발 시간에서 시간과 분 추출
      final depParts = depTime.split(':');
      final depHour = int.parse(depParts[0]);
      final depMin = int.parse(depParts[1]);
      
      // 도착 시간 계산 (소요 시간 추가)
      final durationParts = duration.split('시간');
      final hours = int.parse(durationParts[0].trim());
      final minutes = int.parse(durationParts[1].replaceAll('분', '').trim());
      
      final arrMin = depMin + minutes;
      final arrHour = depHour + hours + (arrMin >= 60 ? 1 : 0);
      final finalArrMin = arrMin >= 60 ? arrMin - 60 : arrMin;
      final arrTime = '${arrHour.toString().padLeft(2, '0')}:${finalArrMin.toString().padLeft(2, '0')}';
      
      // 랜덤하게 가용 날짜 선택 (1~7일 중 랜덤)
      final availableDateCount = 1 + random.nextInt(7);
      final availableDates = <String>[];
      final dateIndices = List.generate(7, (index) => index)..shuffle(random);
      
      for (int j = 0; j < availableDateCount && j < dateIndices.length; j++) {
        final date = baseDate.add(Duration(days: dateIndices[j]));
        availableDates.add('${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}');
      }
      
      schedules.add({
        'departureTime': depTime,
        'arrivalTime': arrTime,
        'duration': duration,
        'flightNumber': flightNumbers[random.nextInt(flightNumbers.length)],
        'availableDates': availableDates,
      });
    }
    
    // 출발 시간 순으로 정렬
    schedules.sort((a, b) => a['departureTime'].compareTo(b['departureTime']));
    
    return schedules;
  }

  String _getDayOfWeek(int weekday) {
    const days = ['월', '화', '수', '목', '금', '토', '일'];
    return days[weekday - 1];
  }

  Widget _buildDepartureArrivalResult() {
    // 더미 출도착 조회 데이터 생성
    final flights = _getDepartureArrivalFlights();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: flights.map((flight) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AeroKColors.white,
            border: Border.all(color: AeroKColors.lightGrayBg),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 항공편 번호 및 상태
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      flight['flightNumber'] ?? 'RF392',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AeroKColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      flight['status'] ?? '출발 전',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AeroKColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // 출발/도착 스케줄
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 출발
                    Row(
                      children: [
                        Text(
                          '스케줄',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AeroKColors.gray,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          flight['departureTime'] ?? '07:25',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AeroKColors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '출발',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AeroKColors.gray,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // 연결선 및 비행기 아이콘
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AeroKColors.darkBlue,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AeroKColors.lightGrayBg,
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: AeroKColors.darkBlue,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AeroKColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // 도착
                    Text(
                      '도착',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AeroKColors.gray,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '스케줄',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AeroKColors.gray,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          flight['arrivalTime'] ?? '09:35',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AeroKColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  List<Map<String, dynamic>> _getDepartureArrivalFlights() {
    // 더미 출도착 조회 데이터 생성
    final baseDate = _departureDate ?? DateTime.now();
    final random = Random(baseDate.millisecondsSinceEpoch);
    
    final flightNumbers = ['RF392', 'RF322', 'RF324', 'RF326', 'RF328'];
    final departureTimes = ['07:25', '09:45', '15:50', '11:30', '13:20'];
    final durations = [130, 130, 135, 125, 140]; // 분 단위
    
    final flightCount = 3 + random.nextInt(2); // 3~4개
    final flights = <Map<String, dynamic>>[];
    
    for (int i = 0; i < flightCount && i < flightNumbers.length; i++) {
      final depTime = departureTimes[i];
      final duration = durations[i];
      final depParts = depTime.split(':');
      final depHour = int.parse(depParts[0]);
      final depMin = int.parse(depParts[1]);
      
      final totalMin = depMin + duration;
      final arrHour = depHour + (totalMin ~/ 60);
      final arrMin = totalMin % 60;
      final arrTime = '${arrHour.toString().padLeft(2, '0')}:${arrMin.toString().padLeft(2, '0')}';
      
      flights.add({
        'flightNumber': flightNumbers[i],
        'status': '출발 전',
        'departureTime': depTime,
        'arrivalTime': arrTime,
      });
    }
    
    return flights;
  }

  String _buildDateText() {
    if (_departureDate == null) {
      return '날짜 선택';
    }
    
    final depDate = '${_departureDate!.year}-${_departureDate!.month.toString().padLeft(2, '0')}-${_departureDate!.day.toString().padLeft(2, '0')}';
    
    if (_isRoundTrip && _returnDate != null) {
      final retDate = '${_returnDate!.year}-${_returnDate!.month.toString().padLeft(2, '0')}-${_returnDate!.day.toString().padLeft(2, '0')}';
      return '$depDate ~ $retDate';
    }
    
    return depDate;
  }

  void _showLocationPicker(BuildContext context, bool isDeparture) {
    // 지역별 여행지 목록 (FlightBookingScreen과 동일한 구조)
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

                      return ListTile(
                        title: Text(fullName),
                        onTap: () {
                          setState(() {
                            if (isDeparture) {
                              _departure = fullName;
                            } else {
                              _arrival = fullName;
                            }
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

  // 지역명과 영문 코드를 분리하여 표시하는 위젯
  Widget _buildLocationText(String? location, bool isLeftAlign) {
    if (location == null || location == '출발' || location == '도착') {
      return Column(
        crossAxisAlignment: isLeftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            location ?? (isLeftAlign ? '출발' : '도착'),
            textAlign: isLeftAlign ? TextAlign.left : TextAlign.right,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AeroKColors.black,
            ),
          ),
        ],
      );
    }

    // "CJU 제주" 또는 "제주 CJU" 형식 파싱
    final parts = location.split(' ');
    String cityName = '';
    String code = '';

    if (parts.length >= 2) {
      // 마지막 부분이 영문 코드인지 확인 (대문자 3글자)
      final lastPart = parts.last;
      if (lastPart.length == 3 && lastPart == lastPart.toUpperCase() && 
          lastPart.contains(RegExp(r'^[A-Z]+$'))) {
        code = lastPart;
        cityName = parts.sublist(0, parts.length - 1).join(' ');
      } else {
        // 첫 번째 부분이 영문 코드인지 확인
        final firstPart = parts.first;
        if (firstPart.length == 3 && firstPart == firstPart.toUpperCase() && 
            firstPart.contains(RegExp(r'^[A-Z]+$'))) {
          code = firstPart;
          cityName = parts.sublist(1).join(' ');
        } else {
          // 영문 코드를 찾지 못한 경우 전체를 지역명으로 표시
          cityName = location;
        }
      }
    } else {
      cityName = location;
    }

    // 지역명 길이에 따라 폰트 크기 조정
    double fontSize = 24;
    if (cityName.length > 8) {
      fontSize = 18; // 긴 이름 (9자 이상)
    } else if (cityName.length > 5) {
      fontSize = 20; // 중간 이름 (6-8자)
    }

    return Column(
      crossAxisAlignment: isLeftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          cityName,
          textAlign: isLeftAlign ? TextAlign.left : TextAlign.right,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AeroKColors.black,
          ),
        ),
        if (code.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            code,
            textAlign: isLeftAlign ? TextAlign.left : TextAlign.right,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AeroKColors.gray,
            ),
          ),
        ],
      ],
    );
  }
}


