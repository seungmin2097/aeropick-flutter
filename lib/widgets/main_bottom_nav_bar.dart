import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../screens/main_screen.dart';

/// 메인 하단 네비게이션 바
/// - [currentIndex]: 현재 활성화된 탭 인덱스 (0~4)
/// - 어디서든 사용 가능하며, 탭을 누르면 MainScreen 으로 이동합니다.
class MainBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const MainBottomNavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => MainScreen(initialIndex: index),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      selectedItemColor: AeroKColors.darkNavy,
      unselectedItemColor: Colors.grey,
      backgroundColor: AeroKColors.white,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.flight),
          label: '항공권 예매',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: AeroKColors.yellowGradient,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: AeroKColors.yellow.withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(
              Icons.book,
              color: AeroKColors.darkNavy,
              size: 24,
            ),
          ),
          label: '나의 예약',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Aero Pick!',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.flight_takeoff),
          label: '운항 정보',
        ),
      ],
    );
  }
}


