import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import 'stamp_registration_screen.dart';

class GachaScreen extends StatelessWidget {
  const GachaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Aero Pick! 탭의 메인 화면은 QR 등록 안내 화면(가챠 + QR CODE 스캔하기)
    return const StampRegistrationScreen();
  }
}


