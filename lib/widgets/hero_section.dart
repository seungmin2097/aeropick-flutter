import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class HeroSection extends StatelessWidget {
  final bool isRoundTrip;
  final ValueChanged<bool> onTripTypeChanged;
  final String? departure;
  final String? arrival;
  final VoidCallback? onDepartureTap;
  final VoidCallback? onArrivalTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onSwapTap;

  const HeroSection({
    super.key,
    required this.isRoundTrip,
    required this.onTripTypeChanged,
    this.departure,
    this.arrival,
    this.onDepartureTap,
    this.onArrivalTap,
    this.onSearchTap,
    this.onSwapTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio.clamp(1.0, 3.0); // 최대 3배로 제한
    
    // 이미지 원본 크기: 1092x1333
    // 이미지 비율: 1092/1333 ≈ 0.819
    // 화면 너비에 맞춰 높이 계산
    final imageAspectRatio = 1092.0 / 1333.0;
    final calculatedHeight = screenWidth / imageAspectRatio;
    
    // 화면 크기에 맞게 이미지 크기 조정 (메모리 최적화)
    final bgImageWidth = 1092.0;
    final bgImageHeight = 1333.0;
    
    // 메모리 사용량 제한
    final maxCacheWidth = (screenWidth * 2.0).round();
    final maxCacheHeight = (calculatedHeight * 2.0).round();
    
    return Container(
      height: calculatedHeight,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 배경: 전체 화면에 하늘 이미지 표시
          RepaintBoundary(
            child: Image.asset(
              'assets/image 46.png',
              width: double.infinity,
              height: calculatedHeight,
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
              cacheWidth: maxCacheWidth,
              cacheHeight: maxCacheHeight,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: calculatedHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF87CEEB),
                        const Color(0xFFB0E0E6),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // 검색 위젯 (중앙 하단)
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 슬로건 텍스트 (검색 위젯 위에 배치)
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '자유, 낭만, 추억\n에어로케이와 함께해요!',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.33,
                      letterSpacing: -0.18,
                      color: AeroKColors.white,
                    ),
                  ),
                ),
                _buildSearchWidget(context, screenWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchWidget(BuildContext context, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: AeroKColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 왕복/편도 토글 (상단)
          Container(
            margin: const EdgeInsets.only(top: 14),
            width: 311,
            height: 44,
            decoration: BoxDecoration(
              color: AeroKColors.chartGray,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  left: isRoundTrip ? 0 : 155,
                  top: 0,
                  child: Container(
                    width: 156,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AeroKColors.darkNavy,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onTripTypeChanged(true),
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          child: Text(
                            '왕복',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.18,
                              color: isRoundTrip
                                  ? AeroKColors.white
                                  : AeroKColors.gray,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onTripTypeChanged(false),
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          child: Text(
                            '편도',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.18,
                              color: isRoundTrip
                                  ? AeroKColors.gray
                                  : AeroKColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // 출발/도착 입력 필드
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // 출발
                Expanded(
                  child: GestureDetector(
                    onTap: onDepartureTap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.18,
                            color: AeroKColors.gray,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _buildLocationText(departure, true),
                      ],
                    ),
                  ),
                ),
                // 교환 아이콘
                GestureDetector(
                  onTap: onSwapTap,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AeroKColors.gray,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.swap_horiz,
                      size: 16,
                      color: AeroKColors.white,
                    ),
                  ),
                ),
                // 도착
                Expanded(
                  child: GestureDetector(
                    onTap: onArrivalTap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'To',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.18,
                            color: AeroKColors.gray,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _buildLocationText(arrival, false),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // 지역명과 영문 코드를 분리하여 표시하는 위젯
  Widget _buildLocationText(String? location, bool isLeftAlign) {
    if (location == null || location == '출발' || location == '도착') {
      return Text(
        location ?? (isLeftAlign ? '출발' : '도착'),
        textAlign: isLeftAlign ? TextAlign.left : TextAlign.right,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 30,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.18,
          color: AeroKColors.gray,
        ),
      );
    }

    // "CJU 제주" 또는 "제주 CJU" 형식 파싱
    final parts = location.split(' ');
    String cityName = '';
    String code = '';

    if (parts.length >= 2) {
      // 마지막 부분이 영문 코드인지 확인 (대문자 3글자)
      final lastPart = parts.last;
      if (lastPart.length == 3 && lastPart == lastPart.toUpperCase() && 
          lastPart.contains(RegExp(r'^[A-Z]+$'))) {
        code = lastPart;
        cityName = parts.sublist(0, parts.length - 1).join(' ');
      } else {
        // 첫 번째 부분이 영문 코드인지 확인
        final firstPart = parts.first;
        if (firstPart.length == 3 && firstPart == firstPart.toUpperCase() && 
            firstPart.contains(RegExp(r'^[A-Z]+$'))) {
          code = firstPart;
          cityName = parts.sublist(1).join(' ');
        } else {
          // 영문 코드를 찾지 못한 경우 전체를 지역명으로 표시
          cityName = location;
        }
      }
    } else {
      cityName = location;
    }

    // 지역명 길이에 따라 폰트 크기 조정
    double fontSize = 30;
    if (cityName.length > 8) {
      fontSize = 22; // 긴 이름 (9자 이상)
    } else if (cityName.length > 5) {
      fontSize = 26; // 중간 이름 (6-8자)
    }

    return Column(
      crossAxisAlignment: isLeftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          cityName,
          textAlign: isLeftAlign ? TextAlign.left : TextAlign.right,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.18,
            color: AeroKColors.darkNavy,
          ),
        ),
        if (code.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            code,
            textAlign: isLeftAlign ? TextAlign.left : TextAlign.right,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.18,
              color: AeroKColors.gray,
            ),
          ),
        ],
      ],
    );
  }
}

