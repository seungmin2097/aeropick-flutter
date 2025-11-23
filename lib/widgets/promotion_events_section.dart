import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class PromotionEventsSection extends StatelessWidget {
  const PromotionEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '프로모션 이벤트를 확인하세요!',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.18,
                    color: AeroKColors.darkBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  // 전체 보기
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '전체 보기',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AeroKColors.gray,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 14,
                      color: AeroKColors.gray,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // 작은 프로모션 카드들 (4개, 한 줄)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _buildSmallPromotionCard(
                  title: 'PROMOTION',
                  subtitle: '일본 항공권·호텔\n더블 할인 프로모션',
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.shade300,
                      Colors.green.shade500,
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildSmallPromotionCard(
                  title: 'SCHEDULE',
                  subtitle: '주 3회 운항\n인천-이너몽골',
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange.shade300,
                      Colors.red.shade400,
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildSmallPromotionCard(
                  title: 'PROMOTION',
                  subtitle: '에어로케이 블프 특가\n최대 95% 할인',
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFFFD700),
                      const Color(0xFFFFA500),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildSmallPromotionCard(
                  title: 'SCHEDULE',
                  subtitle: '매일 단독 운항\n청주 – 세부',
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF0D47A1),
                      const Color(0xFF1976D2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallPromotionCard({
    required String title,
    required String subtitle,
    required Gradient gradient,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AeroKColors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AeroKColors.white,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

