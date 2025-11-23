import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class LowestPriceModule extends StatefulWidget {
  const LowestPriceModule({super.key});

  @override
  State<LowestPriceModule> createState() => _LowestPriceModuleState();
}

class _LowestPriceModuleState extends State<LowestPriceModule> {
  int selectedDestination = 0;

  // 목적지 목록 (대한민국, 일본, 동북아시아, 동남아시아)
  final List<Map<String, dynamic>> destinations = [
    {'name': '제주도', 'code': 'CJU', 'region': '대한민국'},
    {'name': '도쿄', 'code': 'NRT', 'region': '일본'},
    {'name': '다낭', 'code': 'DAD', 'region': '동남아시아'},
    {'name': '오사카', 'code': 'KIX', 'region': '일본'},
    {'name': '타이베이', 'code': 'TPE', 'region': '동북아시아'},
    {'name': '세부', 'code': 'CEB', 'region': '동남아시아'},
    {'name': '오키나와', 'code': 'OKA', 'region': '일본'},
    {'name': '후쿠오카', 'code': 'FUK', 'region': '일본'},
  ];

  // 각 목적지별 가격 데이터 (만원 단위)
  final Map<int, List<double>> destinationPrices = {
    0: [52.7, 65.0, 58.0, 62.0, 68.0, 75.0, 70.0, 63.0], // 제주도
    1: [450.0, 480.0, 460.0, 470.0, 490.0, 500.0, 485.0, 475.0], // 도쿄
    2: [400.0, 420.0, 410.0, 415.0, 430.0, 440.0, 425.0, 418.0], // 다낭
    3: [420.0, 440.0, 430.0, 435.0, 450.0, 460.0, 445.0, 438.0], // 오사카
    4: [350.0, 370.0, 360.0, 365.0, 380.0, 390.0, 375.0, 368.0], // 타이베이
    5: [380.0, 400.0, 390.0, 395.0, 410.0, 420.0, 405.0, 398.0], // 세부
    6: [480.0, 500.0, 490.0, 495.0, 510.0, 520.0, 505.0, 498.0], // 오키나와
    7: [430.0, 450.0, 440.0, 445.0, 460.0, 470.0, 455.0, 448.0], // 후쿠오카
  };

  // 각 목적지별 바 높이 (px)
  final Map<int, List<double>> destinationBarHeights = {
    0: [57.0, 82.0, 43.0, 34.0, 74.0, 102.0, 67.0, 43.0], // 제주도
    1: [90.0, 95.0, 88.0, 92.0, 98.0, 100.0, 94.0, 91.0], // 도쿄
    2: [80.0, 84.0, 82.0, 83.0, 86.0, 88.0, 85.0, 84.0], // 다낭
    3: [84.0, 88.0, 86.0, 87.0, 90.0, 92.0, 89.0, 88.0], // 오사카
    4: [70.0, 74.0, 72.0, 73.0, 76.0, 78.0, 75.0, 74.0], // 타이베이
    5: [76.0, 80.0, 78.0, 79.0, 82.0, 84.0, 81.0, 80.0], // 세부
    6: [96.0, 100.0, 98.0, 99.0, 102.0, 104.0, 101.0, 100.0], // 오키나와
    7: [86.0, 90.0, 88.0, 89.0, 92.0, 94.0, 91.0, 90.0], // 후쿠오카
  };

  final List<String> dates = ['11/01', '11/02', '11/03', '11/04', '11/05', '11/06', '11/07', '11/08'];

  List<double> get prices => destinationPrices[selectedDestination] ?? destinationPrices[0]!;
  List<double> get barHeights => destinationBarHeights[selectedDestination] ?? destinationBarHeights[0]!;

  double get minPrice => prices.reduce((a, b) => a < b ? a : b);
  int get minPriceIndex => prices.indexOf(minPrice);
  
  String get formattedMinPrice {
    // minPrice는 만원 단위이므로 10000을 곱해서 원 단위로 변환
    final price = (minPrice * 10000).toInt();
    return price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxBarHeight = 117.0; // 바의 최대 높이

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          Text(
            '최저가 확인하기!',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.18,
              color: AeroKColors.darkBlue,
            ),
          ),
          const SizedBox(height: 20),
          // 목적지 탭 (스크롤 가능)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(destinations.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: index < destinations.length - 1 ? 16 : 0),
                  child: _buildDestinationTab(destinations[index]['name'] as String, index),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          // 가격 표시 (중앙 정렬)
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AeroKColors.darkBlue,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                'KRW ${formattedMinPrice}',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.18,
                  color: AeroKColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // 바 차트 (중앙 정렬)
          SizedBox(
            height: 150,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(dates.length, (index) {
                final barHeight = barHeights[index];
                final isMinPrice = index == minPriceIndex;
                
                return Container(
                  margin: EdgeInsets.only(
                    right: index < dates.length - 1 ? 4 : 0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 바 (Stack으로 배경과 실제 바 겹침)
                      SizedBox(
                        width: 23,
                        height: maxBarHeight,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // 배경 바 (회색)
                            Container(
                              width: 23,
                              height: maxBarHeight,
                              decoration: BoxDecoration(
                                color: AeroKColors.chartGray,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            // 실제 가격 바
                            Container(
                              width: 23,
                              height: barHeight,
                              decoration: BoxDecoration(
                                color: isMinPrice
                                    ? AeroKColors.darkBlue
                                    : AeroKColors.yellow,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      // 날짜
                      Text(
                        dates[index],
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.18,
                          color: isMinPrice
                              ? AeroKColors.darkBlue
                              : AeroKColors.gray,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // 최저가 노선 확인하기 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // 최저가 노선 확인
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AeroKColors.darkBlue,
                foregroundColor: AeroKColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                '최저가 노선 확인하기',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationTab(String name, int index) {
    final isSelected = selectedDestination == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDestination = index;
        });
      },
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected)
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: AeroKColors.darkBlue,
                ),
              if (isSelected) const SizedBox(width: 4),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.18,
                  color: isSelected ? AeroKColors.black : AeroKColors.gray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

