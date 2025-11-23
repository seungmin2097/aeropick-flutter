import 'package:flutter/material.dart';
import 'main_screen.dart';
import '../widgets/aerok_logo.dart';
import '../theme/aerok_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroKColors.darkNavy,
      body: Container(
        decoration: BoxDecoration(
          color: AeroKColors.darkNavy,
        ),
        child: Stack(
          children: [
            // 로고를 화면 중앙에 배치 (피그마: top: 389px, 화면 높이 852px 기준 약 45.7% 위치)
            // Flutter에서는 다양한 화면 크기에 대응하기 위해 중앙 기준 약간 위로 배치
            Center(
              child: Transform.translate(
                offset: const Offset(0, -30), // 화면 중앙 기준 약간 위로
                child: const AeroKLogo(
                  width: 210,
                  height: 44,
                ),
              ),
            ),
            // 하단에 로딩 인디케이터 (선택적)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AeroKColors.yellow),
                  strokeWidth: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

