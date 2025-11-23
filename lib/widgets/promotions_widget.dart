import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class PromotionsWidget extends StatelessWidget {
  final List<String> items;
  const PromotionsWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final title = items[index];
          return Container(
            width: 220,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AeroKColors.yellow.withOpacity(0.1),
                  AeroKColors.lightYellow.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AeroKColors.yellow.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: AeroKColors.yellow.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AeroKColors.yellow,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '프로모션',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AeroKColors.darkNavy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AeroKColors.darkNavy,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: items.length,
      ),
    );
  }
}


