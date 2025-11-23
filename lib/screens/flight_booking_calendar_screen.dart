import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

/// 항공권 예매 - 날짜 선택 / 달력 화면
/// - 2026년까지 월 이동 가능
/// - 날짜를 탭해서 출발/도착일 범위 선택
/// - 완료 버튼 클릭 시 선택 결과를 상위로 전달
class FlightBookingCalendarScreen extends StatefulWidget {
  final DateTime? initialDeparture;
  final DateTime? initialReturn;
  final bool isRoundTrip;

  const FlightBookingCalendarScreen({
    super.key,
    this.initialDeparture,
    this.initialReturn,
    this.isRoundTrip = true,
  });

  @override
  State<FlightBookingCalendarScreen> createState() =>
      _FlightBookingCalendarScreenState();
}

class _FlightBookingCalendarScreenState
    extends State<FlightBookingCalendarScreen> {
  late DateTime _currentMonth;
  DateTime? _departureDate;
  DateTime? _returnDate;

  @override
  void initState() {
    super.initState();
    _departureDate = widget.initialDeparture;
    _returnDate = widget.initialReturn;
    _currentMonth = (_departureDate ?? DateTime.now());
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--';
    const weekDays = ['월', '화', '수', '목', '금', '토', '일'];
    final w = weekDays[date.weekday - 1];
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}($w)';
  }

  void _onDayTapped(DateTime day) {
    setState(() {
      if (_departureDate == null || (_departureDate != null && _returnDate != null)) {
        // 새로 범위 선택 시작
        _departureDate = day;
        _returnDate = null;
      } else {
        if (day.isBefore(_departureDate!)) {
          // 더 이른 날짜를 선택하면 출발일만 변경
          _departureDate = day;
        } else if (day.isAtSameMomentAs(_departureDate!)) {
          // 같은 날 다시 누르면 단일 날짜만 선택
          _returnDate = null;
        } else {
          // 출발일 이후 날짜면 도착일로 설정
          _returnDate = day;
        }
      }
    });
  }

  void _changeMonth(int offset) {
    final newMonth = DateTime(_currentMonth.year, _currentMonth.month + offset, 1);
    // 2026년 12월까지 허용 (필요시 범위 조정 가능)
    final minMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    final maxMonth = DateTime(2026, 12, 1);

    if (newMonth.isBefore(minMonth) || newMonth.isAfter(maxMonth)) return;

    setState(() {
      _currentMonth = newMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroKColors.white,
      appBar: AppBar(
        backgroundColor: AeroKColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AeroKColors.darkBlue),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            // 상단 날짜 범위 + 아이콘
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDate(_departureDate),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AeroKColors.darkBlue,
                    ),
                  ),
                  Text(
                    widget.isRoundTrip ? _formatDate(_returnDate) : '--',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AeroKColors.darkBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // 요일 헤더
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _WeekdayLabel(label: '일', color: Color(0xFFFF3131)),
                  _WeekdayLabel(label: '월'),
                  _WeekdayLabel(label: '화'),
                  _WeekdayLabel(label: '수'),
                  _WeekdayLabel(label: '목'),
                  _WeekdayLabel(label: '금'),
                  _WeekdayLabel(label: '토', color: Color(0xFF408EFF)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // 구분선
            const Divider(
              height: 1,
              thickness: 1,
              indent: 22,
              endIndent: 22,
              color: Color(0xFFD9D9D9),
            ),
            const SizedBox(height: 16),
            // 월 타이틀 + 이전/다음
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => _changeMonth(-1),
                    icon: const Icon(Icons.chevron_left),
                    color: AeroKColors.darkBlue,
                  ),
                  Text(
                    '${_currentMonth.year}.${_currentMonth.month.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AeroKColors.darkBlue,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _changeMonth(1),
                    icon: const Icon(Icons.chevron_right),
                    color: AeroKColors.darkBlue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // 달력 그리드
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildCalendarGrid(),
            ),
            const Spacer(),
            // 하단 결제 금액 영역 (나중에 API 연동)
            Container(
              decoration: const BoxDecoration(
                color: AeroKColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 7,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop<Map<String, DateTime?>>(
                      context,
                      {
                        'departure': _departureDate,
                        'return': widget.isRoundTrip ? _returnDate : null,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AeroKColors.darkNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0:일 ~ 6:토

    final List<Widget> rows = [];
    int day = 1 - firstWeekday;

    for (int week = 0; week < 6; week++) {
      final List<Widget> cells = [];
      for (int i = 0; i < 7; i++) {
        if (day < 1 || day > daysInMonth) {
          cells.add(const SizedBox(
            width: 41,
            height: 32,
          ));
        } else {
          final currentDay =
              DateTime(_currentMonth.year, _currentMonth.month, day);
          final bool isSelectedStart =
              _departureDate != null && _isSameDate(currentDay, _departureDate!);
          final bool isSelectedEnd =
              _returnDate != null && _isSameDate(currentDay, _returnDate!);
          final bool isInRange = _departureDate != null &&
              _returnDate != null &&
              currentDay.isAfter(_departureDate!) &&
              currentDay.isBefore(_returnDate!);

          Color bgColor = Colors.transparent;
          if (isSelectedStart || isSelectedEnd) {
            bgColor = const Color(0xFF0069FF);
          } else if (isInRange) {
            bgColor = const Color(0xFFBFDAFF);
          }

          cells.add(
            GestureDetector(
              onTap: () => _onDayTapped(currentDay),
              child: Container(
                width: 41,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight:
                        (isSelectedStart || isSelectedEnd) ? FontWeight.w700 : FontWeight.w500,
                    color: (isSelectedStart || isSelectedEnd)
                        ? Colors.white
                        : const Color(0xFF0A1811),
                  ),
                ),
              ),
            ),
          );
        }
        day++;
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: cells,
      ));
      rows.add(const SizedBox(height: 8));
    }

    return Column(children: rows);
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String label;
  final Color color;

  const _WeekdayLabel({
    required this.label,
    this.color = const Color(0xFF949494),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}


