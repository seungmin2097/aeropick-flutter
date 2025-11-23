import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class KlookPromotionBanner extends StatelessWidget {
  const KlookPromotionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
      decoration: BoxDecoration(
        color: AeroKColors.darkBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '클룩 호텔 2박만 예약해도 최대 5만원 할인!',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.38,
                letterSpacing: -0.18,
                color: AeroKColors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 54,
            height: 24,
            decoration: BoxDecoration(
              color: AeroKColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                'klook',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AeroKColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

