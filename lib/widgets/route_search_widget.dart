import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class RouteSearchWidget extends StatelessWidget {
  final VoidCallback onTap;
  const RouteSearchWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AeroKColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AeroKColors.darkNavy.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: AeroKColors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                '노선 검색 (출발지/도착지)',
                style: TextStyle(color: AeroKColors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Icon(Icons.chevron_right, color: AeroKColors.white),
          ],
        ),
      ),
    );
  }
}


