import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_logo.dart';
import 'login_screen.dart';
import 'flight_booking_screen.dart';
import 'price_booking_screen.dart';
import 'fare_info_screen.dart';
import 'group_booking_info_screen.dart';
import 'fee_info_screen.dart';
import 'flight_schedule_info_screen.dart';
import 'flight_info_screen.dart';
import 'online_payment_info_screen.dart';
import 'additional_services_screen.dart';

/// 메뉴 화면 (좌측 메뉴 + 우측 콘텐츠)
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _selectedMenu = '예약';

  final Map<String, List<Map<String, dynamic>>> _menuContent = {
    '예약': [
      {
        'category': '항공권',
        'items': [
          {'title': '항공권 예매', 'route': 'flight_booking'},
          {'title': '가격으로 예매', 'route': 'price_booking'},
        ],
      },
      {
        'category': '정보',
        'items': [
          {'title': '운임 안내', 'route': 'fare_info'},
          {'title': '단체 항공권 예매 안내', 'route': 'group_booking_info'},
          {'title': '수수료 및 위약금 안내', 'route': 'fee_info'},
          {'title': '운항 스케줄 및 운항 노선 안내', 'route': 'flight_schedule_info'},
          {'title': '운항 정보', 'route': 'flight_info'},
          {'title': '온라인 결제', 'route': 'online_payment_info'},
        ],
      },
      {
        'category': '부가서비스',
        'items': [
          {'title': '부가서비스 안내', 'route': 'additional_services'},
        ],
      },
    ],
    '예약조회': [],
    '탑승': [],
    '여행준비': [],
    '이벤트': [],
    '브랜드 샵': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroKColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 헤더
            _buildHeader(),
            // 회원가입/로그인 버튼
            _buildAuthButtons(),
            // 검색 바
            _buildSearchBar(),
            // 메인 콘텐츠 (좌측 메뉴 + 우측 콘텐츠)
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 좌측 메뉴
                  _buildLeftMenu(),
                  // 우측 콘텐츠
                  Expanded(
                    child: _buildRightContent(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 홈 아이콘
          IconButton(
            icon: const Icon(Icons.home, color: AeroKColors.gray),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          // 언어/통화
          Text(
            '한국(Korean) / KRW',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: FontWeight.w300,
              color: AeroKColors.gray,
            ),
          ),
          // X 버튼
          IconButton(
            icon: const Icon(Icons.close, color: AeroKColors.gray),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // 회원가입 버튼
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AeroKColors.white,
                border: Border.all(color: AeroKColors.darkBlue, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  // 회원가입 화면으로 이동 (추후 구현)
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AeroKColors.darkBlue,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 13),
          // 로그인 버튼
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AeroKColors.darkBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  '로그인',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AeroKColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AeroKColors.white,
          border: Border.all(color: AeroKColors.lightGrayBg),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                '검색어를 입력하세요.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AeroKColors.darkBlue,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: AeroKColors.darkBlue),
              onPressed: () {
                // 검색 기능 (추후 구현)
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftMenu() {
    final menuItems = ['예약', '예약조회', '탑승', '여행준비', '이벤트', '브랜드 샵'];

    return Container(
      width: 127,
      color: AeroKColors.chartGray,
      child: Column(
        children: [
          // 구분선
          Container(
            height: 3,
            color: AeroKColors.lightGrayBg,
          ),
          // 메뉴 아이템들
          ...menuItems.map((item) {
            final isSelected = _selectedMenu == item;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMenu = item;
                });
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: isSelected ? AeroKColors.white : Colors.transparent,
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? AeroKColors.darkBlue : AeroKColors.black,
                        ),
                      ),
                    ),
                  ),
                  // 선택된 항목의 왼쪽 파란색 바
                  if (isSelected)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 5,
                        color: AeroKColors.darkBlue,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRightContent() {
    final content = _menuContent[_selectedMenu] ?? [];

    if (content.isEmpty) {
      return Center(
        child: Text(
          '$_selectedMenu 콘텐츠 준비 중',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: AeroKColors.gray,
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(left: 20, top: 12, right: 20, bottom: 20),
      children: content.map((section) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 카테고리 제목
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                section['category'] as String,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AeroKColors.darkBlue,
                ),
              ),
            ),
            // 아이템들
            ...(section['items'] as List<Map<String, dynamic>>).map((item) {
              return InkWell(
                onTap: () {
                  final route = item['route'] as String?;
                  if (route == 'flight_booking') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FlightBookingScreen(),
                      ),
                    );
                  } else if (route == 'price_booking') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PriceBookingScreen(),
                      ),
                    );
                  } else if (route == 'fare_info') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FareInfoScreen(),
                      ),
                    );
                  } else if (route == 'group_booking_info') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GroupBookingInfoScreen(),
                      ),
                    );
                  } else if (route == 'fee_info') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeeInfoScreen(),
                      ),
                    );
                  } else if (route == 'flight_schedule_info') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FlightScheduleInfoScreen(),
                      ),
                    );
                  } else if (route == 'flight_info') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FlightInfoScreen(),
                      ),
                    );
                  } else if (route == 'online_payment_info') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnlinePaymentInfoScreen(),
                      ),
                    );
                  } else if (route == 'additional_services') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdditionalServicesScreen(),
                      ),
                    );
                  } else {
                    // 다른 항목들은 추후 구현
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item['title']} 기능 준비 중'),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }
}

