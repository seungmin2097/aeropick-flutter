import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class AeroKLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final bool useDarkText; // 밝은 배경에서 사용할 경우 true
  
  const AeroKLogo({
    super.key,
    this.width,
    this.height,
    this.useDarkText = false,
  });

  @override
  Widget build(BuildContext context) {
    // 피그마 디자인: width: 210px, height: 44px
    final logoWidth = width ?? 210.0;
    final logoHeight = height ?? 44.0;
    final fontSize = logoHeight * 0.75; // 약 33px
    final textColor = useDarkText ? AeroKColors.darkNavy : AeroKColors.white;
    final underscoreColor = AeroKColors.yellow;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Aero (흰색)
        Text(
          'Aero',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: 0,
            height: 1,
          ),
        ),
        // _ (노란색)
        Text(
          '_',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: underscoreColor,
            letterSpacing: 0,
            height: 1,
          ),
        ),
        // K (흰색)
        Text(
          'K',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: 0,
            height: 1,
          ),
        ),
      ],
    );
  }
}

