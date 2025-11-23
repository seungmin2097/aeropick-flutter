import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'gacha_screen.dart';
import 'flight_booking_screen.dart';
import 'my_reservations_screen.dart';
import 'flight_info_screen.dart';
import 'login_screen.dart';
import '../theme/aerok_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FlightBookingScreen(),
    const MyReservationsScreen(),
    const GachaScreen(),
    const FlightInfoScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
              child: const Icon(Icons.book, color: AeroKColors.darkNavy, size: 24),
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
      ),
    );
  }
}

