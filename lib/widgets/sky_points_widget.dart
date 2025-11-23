import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class SkyPointsWidget extends StatelessWidget {
  final int points;
  const SkyPointsWidget({super.key, required this.points});

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
            color: AeroKColors.yellow.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AeroKColors.yellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.stars, color: AeroKColors.yellow),
          ),
          const SizedBox(width: 12),
          const Text('나의 하늘 포인트', style: TextStyle(fontWeight: FontWeight.w600, color: AeroKColors.darkNavy)),
          const Spacer(),
          Text(
            '$points P',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AeroKColors.darkNavy,
            ),
          ),
        ],
      ),
    );
  }
}


