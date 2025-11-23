import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';
import '../widgets/main_bottom_nav_bar.dart';
import '../providers/stamp_provider.dart';
import '../providers/user_provider.dart';
import 'stamp_progress_screen.dart';

class StampEarnedScreen extends StatefulWidget {
  const StampEarnedScreen({super.key});

  @override
  State<StampEarnedScreen> createState() => _StampEarnedScreenState();
}

class _StampEarnedScreenState extends State<StampEarnedScreen> {
  bool _hasCheckedRewards = false;

  void _checkAndShowRewards(BuildContext context, int collectedCount) {
    if (_hasCheckedRewards) return;
    _hasCheckedRewards = true;

    // 이전 스탬프 개수 (스탬프를 방금 추가했으므로 현재 개수 - 1)
    final previousCount = collectedCount - 1;

    // 5개 달성 시 알림 (이전에 5개 미만이었고 현재 5개 이상)
    if (collectedCount >= 5 && previousCount < 5) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _showRewardDialog(
            context,
            title: '축하합니다!',
            message: '30% 할인 쿠폰을 받았습니다!',
            reward: '30% 할인 쿠폰',
            onConfirm: () {
              Navigator.of(context).pop();
              _navigateToProgressScreen(context);
            },
          );
          return;
        }
      });
      return; // 5개 알림을 표시했으면 10개 알림은 표시하지 않음
    }
    
    // 10개 달성 시 알림 (이전에 10개 미만이었고 현재 10개 이상)
    if (collectedCount >= 10 && previousCount < 10) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _showRewardDialog(
            context,
            title: '축하합니다!',
            message: '왕복 항공권 1인 2매 쿠폰을 받았습니다!',
            reward: '왕복 항공권 1인 2매',
            onConfirm: () {
              Navigator.of(context).pop();
              _navigateToProgressScreen(context);
            },
          );
          return;
        }
      });
    }
  }

  void _navigateToProgressScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const StampProgressScreen(),
      ),
    );
  }

  void _showRewardDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String reward,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AeroKColors.darkBlue,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.celebration,
                size: 64,
                color: AeroKColors.yellow,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AeroKColors.darkBlue,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AeroKColors.yellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AeroKColors.yellow,
                    width: 2,
                  ),
                ),
                child: Text(
                  reward,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AeroKColors.darkBlue,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: onConfirm,
              child: Text(
                '확인',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AeroKColors.darkBlue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final stampProvider = context.watch<StampProvider>();

    final int userId = userProvider.userId;
    final int collectedCount =
        stampProvider.getUserStampsByUserId(userId).length;
    final int totalCount = stampProvider.locations.length;

    // 스탬프 개수 확인 및 보상 체크
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowRewards(context, collectedCount);
    });

    return Scaffold(
      backgroundColor: AeroKColors.white,
      appBar: const AerokTopAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 40),
          // 상단 텍스트 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // "Aero Pick! 스탬프가 적립되었어요!"
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      height: 35 / 26,
                      letterSpacing: -0.18,
                      color: AeroKColors.darkBlue,
                    ),
                    children: [
                      const TextSpan(text: 'Aero Pick!\n'),
                      TextSpan(
                        text: '스탬프',
                        style: TextStyle(color: AeroKColors.yellow),
                      ),
                      const TextSpan(
                        text: '가 적립되었어요!',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // 1/10
                Text(
                  '${collectedCount.clamp(0, totalCount)}/$totalCount',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 35 / 16,
                    letterSpacing: -0.18,
                    color: AeroKColors.gray,
                  ),
                ),
                const SizedBox(height: 20),
                // 별 아이콘 + "1개 적립"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: AeroKColors.yellow,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${collectedCount}개 적립',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.18,
                        color: AeroKColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // 스탬프 이미지 영역
          Expanded(
            child: Center(
              child: SizedBox(
                width: 304,
                height: 304,
                child: Image.asset(
                  'assets/stamp.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 안내 문구
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              '스탬프를 모아 혜택을 확인해 보세요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 22 / 14,
                letterSpacing: -0.18,
                color: AeroKColors.gray,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // "나의 스탬프 보러 가기" 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 보상 알림이 표시되지 않은 경우에만 바로 이동
                  if (!_hasCheckedRewards || (collectedCount != 5 && collectedCount != 10)) {
                    _navigateToProgressScreen(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AeroKColors.darkBlue,
                  foregroundColor: AeroKColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Text(
                  '나의 스탬프 보러 가기',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
      // Aero Pick! 탭(인덱스 1) 기준
      bottomNavigationBar: const MainBottomNavBar(currentIndex: 1),
    );
  }
}