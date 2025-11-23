import 'package:flutter/material.dart';

class AeroKColors {
  // 브랜드 색상 (피그마 디자인)
  static const Color darkNavy = Color(0xFF1C2C4C); // 어두운 남색 (피그마: #1C2C4C)
  static const Color darkBlue = Color(0xFF002355); // 어두운 파란색 (피그마: #002355)
  static const Color yellow = Color(0xFFFCB44C); // 노란색/오렌지 (피그마: #FCB44C)
  static const Color lightYellow = Color(0xFFFFD580); // 밝은 노란색
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkGray = Color(0xFF2C3E50);
  static const Color lightGray = Color(0xFFE8E8E8);
  static const Color gray = Color(0xFF949494); // 회색 (피그마: #949494)
  static const Color lightGrayBg = Color(0xFFD9D9D9); // 밝은 회색 배경 (피그마: #D9D9D9)
  static const Color chartGray = Color(0xFFEAEAEA); // 차트 회색 (피그마: #EAEAEA)
  static const Color black = Color(0xFF000000);

  // 그라데이션
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [darkNavy, Color(0xFF2A3F5F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient yellowGradient = LinearGradient(
    colors: [yellow, lightYellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

