import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';

/// 운항 스케줄 및 운항 노선 안내 화면
class FlightScheduleInfoScreen extends StatefulWidget {
  const FlightScheduleInfoScreen({super.key});

  @override
  State<FlightScheduleInfoScreen> createState() => _FlightScheduleInfoScreenState();
}

class _FlightScheduleInfoScreenState extends State<FlightScheduleInfoScreen> {
  bool _isRouteInfo = false; // false: 운항 스케줄, true: 운항 노선 안내

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroKColors.white,
      appBar: const AerokTopAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Text(
                '운항 스케줄 및 운항 노선 안내',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AeroKColors.darkBlue,
                ),
              ),
              const SizedBox(height: 24),
              // 탭
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRouteInfo = false;
                        });
                      },
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: !_isRouteInfo ? AeroKColors.darkBlue : AeroKColors.white,
                          border: Border.all(
                            color: !_isRouteInfo ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '운항 스케줄',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: !_isRouteInfo ? AeroKColors.white : AeroKColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRouteInfo = true;
                        });
                      },
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: _isRouteInfo ? AeroKColors.darkBlue : AeroKColors.white,
                          border: Border.all(
                            color: _isRouteInfo ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '운항 노선 안내',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _isRouteInfo ? AeroKColors.white : AeroKColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // 콘텐츠
              if (_isRouteInfo) ...[
                // 운항 노선 안내 콘텐츠
                _buildRouteInfoContent(),
              ] else ...[
                // 운항 스케줄 콘텐츠
                _buildScheduleContent(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleContent() {
    return Column(
      children: [
        // 비행기 내부 이미지 배너
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // 배경 이미지
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/gemini.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // 텍스트 오버레이 (중앙 정렬)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '새로운 여정의 시작, 에어로케이의',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AeroKColors.white,
                          height: 1.5,
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '운항 스케줄을 확인하세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AeroKColors.white,
                          height: 1.5,
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // 전 노선 운항 스케줄 보기 버튼
        Center(
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: AeroKColors.white,
              border: Border.all(color: AeroKColors.darkBlue, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                // 전 노선 운항 스케줄 화면으로 이동 (추후 구현)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('전 노선 운항 스케줄 기능 준비 중'),
                  ),
                );
              },
              child: Text(
                '전 노선 운항 스케줄 보기',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AeroKColors.darkBlue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRouteInfoContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 국내선 섹션
        Text(
          '국내선',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AeroKColors.black,
          ),
        ),
        const SizedBox(height: 16),
        _buildRouteRow('청주', 'CJU 제주'),
        const SizedBox(height: 12),
        _buildRouteRow('제주', 'CJJ 청주'),
        const SizedBox(height: 32),
        // 국제선 섹션
        Text(
          '국제선',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AeroKColors.black,
          ),
        ),
        const SizedBox(height: 16),
        // 청주 출발
        _buildDepartureSection(
          '청주',
          [
            'KIX 오사카/간사이',
            'CXR 나트랑',
            'TAO 칭다오',
            'KKJ 기타큐슈',
            'NGO 나고야',
            'FUK 후쿠오카',
            'OKA 오키나와',
            'HIJ 히로시마',
            'IBR 이바라키',
          ],
          [
            'CRK 클락',
            'CTS 삿포로/신치토세',
            'TPE 타이베이/타오위안',
            'RMQ 타이중',
            'OBO 오비히로',
            'CEB 세부',
            'DAD 다낭',
            'NRT 도쿄/나리타',
          ],
        ),
        const SizedBox(height: 24),
        // 서울/인천 출발
        _buildDepartureSection(
          '서울/인천',
          [
            'HUN 화롄',
            'OBO 오비히로',
          ],
          [
            'IBR 이바라키',
            'KIX 오사카/간사이',
          ],
        ),
        const SizedBox(height: 24),
        // 제주 출발
        _buildDepartureSection(
          '제주',
          [
            'HIJ 히로시마',
          ],
          [],
        ),
      ],
    );
  }

  Widget _buildRouteRow(String departure, String arrival) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AeroKColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AeroKColors.lightGrayBg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            departure,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AeroKColors.black,
            ),
          ),
          Icon(
            Icons.arrow_forward,
            size: 20,
            color: AeroKColors.gray,
          ),
          Text(
            arrival,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AeroKColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartureSection(String departure, List<String> leftDestinations, List<String> rightDestinations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          departure,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AeroKColors.black,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 왼쪽 컬럼
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: leftDestinations.map((dest) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      dest,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AeroKColors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // 오른쪽 컬럼
            if (rightDestinations.isNotEmpty)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rightDestinations.map((dest) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        dest,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AeroKColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

