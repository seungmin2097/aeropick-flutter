import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class GachaGateCard extends StatelessWidget {
  const GachaGateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AeroKColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AeroKColors.lightGray),
        boxShadow: [
          BoxShadow(
            color: AeroKColors.darkNavy.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AeroKColors.yellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.map, color: AeroKColors.yellow),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '에어로 게이트 가챠 위치/혼잡도',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AeroKColors.darkNavy,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '공항 내 가챠 위치와 현재 대기/혼잡 정보를 표시합니다. (데모)',
                  style: TextStyle(color: AeroKColors.darkGray),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AeroKColors.darkGray),
        ],
      ),
    );
  }
}


