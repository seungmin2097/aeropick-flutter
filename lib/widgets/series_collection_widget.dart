import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class SeriesCollectionWidget extends StatelessWidget {
  final List<String> series; // ex) 제주, 재팬 등
  const SeriesCollectionWidget({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 140,
            decoration: BoxDecoration(
              color: AeroKColors.white,
              border: Border.all(color: AeroKColors.lightGray),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AeroKColors.darkNavy.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                series[index],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AeroKColors.darkNavy,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: series.length,
      ),
    );
  }
}


