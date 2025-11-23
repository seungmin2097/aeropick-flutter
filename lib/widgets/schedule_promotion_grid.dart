import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class SchedulePromotionGrid extends StatelessWidget {
  const SchedulePromotionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 제목
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              '스케줄 & 프로모션',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AeroKColors.white,
              ),
            ),
          ),
          // 2x2 그리드
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              _buildPromotionCard(
                title: 'Aero_K',
                subtitle: 'Black Friday',
                description: '에어로케이 블프 특가\n최대 95% 할인',
                badgeText: 'up to\n95%',
                backgroundColor: const Color(0xFFFFD700), // 노란색
                isPromotion: true,
              ),
              _buildScheduleCard(
                title: 'SCHEDULE',
                schedule: '매일 단독 운항',
                route: '청주 – 세부',
                imageType: 'cebu', // 세부 이미지
              ),
              _buildScheduleCard(
                title: 'SCHEDULE',
                schedule: '주 2회 단독 운항',
                route: '인천 — 오비히로(홋카이도)',
                imageType: 'obihiro', // 오비히로 이미지
              ),
              _buildScheduleCard(
                title: 'SCHEDULE',
                schedule: '주 3회 단독 운항',
                route: '인천 – 이바라키(북도쿄)',
                imageType: 'ibaraki', // 이바라키 이미지
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionCard({
    required String title,
    required String subtitle,
    required String description,
    required String badgeText,
    required Color backgroundColor,
    required bool isPromotion,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // 좌우 도시명 리스트 (배경)
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildVerticalText('HIROSHIMA'),
                _buildVerticalText('KITAKYUSHU'),
                _buildVerticalText('QINGDAO'),
                _buildVerticalText('TOKYO'),
                _buildVerticalText('IBARAKI'),
                _buildVerticalText('OSAKA'),
                _buildVerticalText('NAGOYA'),
                _buildVerticalText('FUKUOKA'),
              ],
            ),
          ),
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildVerticalText('DANANG'),
                _buildVerticalText('NHA TRANG'),
                _buildVerticalText('TAIPEI'),
                _buildVerticalText('CEBU'),
                _buildVerticalText('CLARK'),
                _buildVerticalText('HUALIEN'),
                _buildVerticalText('SAPPORO'),
                _buildVerticalText('OBIHIRO'),
                _buildVerticalText('OKIN'),
              ],
            ),
          ),
          // 메인 콘텐츠
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단: Aero_K
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                // Black Friday
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                // 하단: 프로모션 텍스트
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PROMOTION',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 우상단 배지
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'up to',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      badgeText.split('\n')[1],
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 북마크 아이콘
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.bookmark_border,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard({
    required String title,
    required String schedule,
    required String route,
    required String imageType,
  }) {
    // 이미지 타입에 따른 배경색/그라데이션 및 텍스트 색상
    List<Color> gradientColors;
    Color textColor;
    Color bookmarkColor;
    
    switch (imageType) {
      case 'cebu':
        gradientColors = [
          const Color(0xFF0D47A1), // 진한 파란색
          const Color(0xFF1976D2), // 밝은 파란색
        ];
        textColor = Colors.white;
        bookmarkColor = Colors.white;
        break;
      case 'obihiro':
        gradientColors = [
          const Color(0xFFE1F5FE), // 하늘색
          const Color(0xFFB3E5FC), // 밝은 하늘색
        ];
        textColor = Colors.black87;
        bookmarkColor = Colors.black87;
        break;
      case 'ibaraki':
        gradientColors = [
          const Color(0xFFFF6B35), // 주황색
          const Color(0xFFFF8A50), // 밝은 주황색
        ];
        textColor = Colors.white;
        bookmarkColor = Colors.white;
        break;
      default:
        gradientColors = [AeroKColors.darkBlue, AeroKColors.darkBlue];
        textColor = Colors.white;
        bookmarkColor = Colors.white;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
      child: Stack(
        children: [
          // 그라데이션 오버레이 (밝은 배경인 경우 제거)
          if (imageType != 'obihiro')
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                  ],
                ),
              ),
            ),
          // 텍스트 콘텐츠
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  schedule,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  route,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          // 북마크 아이콘
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: bookmarkColor, width: 1.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.bookmark_border,
                color: bookmarkColor,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 8,
          fontWeight: FontWeight.w400,
          color: Colors.black.withOpacity(0.2),
          height: 1.2,
        ),
      ),
    );
  }

}

