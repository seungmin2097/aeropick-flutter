import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class PromotionCarouselBanner extends StatefulWidget {
  const PromotionCarouselBanner({super.key});

  @override
  State<PromotionCarouselBanner> createState() => _PromotionCarouselBannerState();
}

class _PromotionCarouselBannerState extends State<PromotionCarouselBanner> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _banners = [
    {
      'title': 'Aero-K',
      'partner': 'klook',
      'partnerDisplay': 'klook',
      'description': 'Klook 호텔 2박 예약 시 최대 50,000원 할인',
      'hasPartnerLogo': true,
    },
    {
      'title': 'Aero-K',
      'partner': 'Carrot',
      'partnerDisplay': 'Carrot',
      'partnerSubtitle': '캐롯손해보험',
      'description': '해외여행보험 출발7일전 가입 3% 할인',
      'hasPartnerLogo': false,
    },
    {
      'title': 'Aero-K',
      'partner': 'kkday',
      'partnerDisplay': 'kkday',
      'description': '해외 티켓/투어/액티비티 최대 5% 할인',
      'hasPartnerLogo': true,
    },
    {
      'title': 'Aero-K',
      'partner': 'Lotte',
      'partnerDisplay': '롯데렌터카',
      'partnerSubtitle': '대한민국 No.1',
      'description': '대한민국 No.1 롯데렌터카 최대 89% 할인 제공',
      'hasPartnerLogo': false,
    },
    {
      'title': 'Aero-K',
      'partner': 'eSIM',
      'partnerDisplay': null, // eSIM은 X 파트너 없음
      'description': 'eSIM/USIM 최대 10% 할인 혜택',
      'hasPartnerLogo': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % _banners.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    // 타이머 재시작
    _timer?.cancel();
    _startTimer();
  }

  void _goToPreviousPage() {
    if (_pageController.hasClients) {
      final newPage = (_currentPage - 1 + _banners.length) % _banners.length;
      _pageController.animateToPage(
        newPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_pageController.hasClients) {
      final newPage = (_currentPage + 1) % _banners.length;
      _pageController.animateToPage(
        newPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPage(int index) {
    if (_pageController.hasClients && index != _currentPage) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _banners.length,
                itemBuilder: (context, index) {
                  final banner = _banners[index];
                  return _buildBanner(banner);
                },
              ),
              // 좌우 화살표 버튼 (안쪽으로 이동)
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: _goToPreviousPage,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: AeroKColors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.chevron_left,
                        color: AeroKColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: _goToNextPage,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: AeroKColors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.chevron_right,
                        color: AeroKColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // 페이지네이션 도트 (클릭 가능)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) => GestureDetector(
              onTap: () => _goToPage(index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: index == _currentPage ? 8 : 6,
                height: index == _currentPage ? 8 : 6,
                decoration: BoxDecoration(
                  color: index == _currentPage
                      ? AeroKColors.white
                      : AeroKColors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBanner(Map<String, dynamic> banner) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
      decoration: BoxDecoration(
        color: AeroKColors.darkBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 상단: 작은 텍스트 (있는 경우)
          if (banner['partnerSubtitle'] != null)
            Text(
              banner['partnerSubtitle'],
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AeroKColors.white,
              ),
            ),
          if (banner['partnerSubtitle'] != null) const SizedBox(height: 4),
          // 상단: Aero-K X 파트너명 (또는 Aero-K만)
          if (banner['partnerDisplay'] != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  banner['title'],
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AeroKColors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'X',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AeroKColors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  banner['partnerDisplay'],
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AeroKColors.white,
                  ),
                ),
              ],
            )
          else
            Text(
              banner['title'],
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AeroKColors.white,
              ),
            ),
          const SizedBox(height: 12),
          // 하단: 설명 텍스트
          Text(
            banner['description'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AeroKColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

