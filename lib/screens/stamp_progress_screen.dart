import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';
import '../widgets/main_bottom_nav_bar.dart';
import '../providers/stamp_provider.dart';
import '../providers/user_provider.dart';
import 'main_screen.dart';
import 'qr_scan_screen.dart';

/// 나의 스탬프 현황 화면 (원형 진행 바 + 카드 스타일)
class StampProgressScreen extends StatefulWidget {
  const StampProgressScreen({super.key});

  @override
  State<StampProgressScreen> createState() => _StampProgressScreenState();
}

class _StampProgressScreenState extends State<StampProgressScreen> {
  int _previousCount = -1;
  bool _hasShown5Reward = false;
  bool _hasShown10Reward = false;

  @override
  void initState() {
    super.initState();
    // 초기 스탬프 개수 설정을 위해 다음 프레임에서 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = context.read<UserProvider>();
      final stampProvider = context.read<StampProvider>();
      final int userId = userProvider.userId;
      final int collectedCount =
          stampProvider.getUserStampsByUserId(userId).length;
      _previousCount = collectedCount;
    });
  }

  void _checkRewards(int collectedCount) {
    // 이전 개수와 다를 때만 체크 (스탬프가 변경되었을 때)
    if (_previousCount == -1 || _previousCount == collectedCount) {
      return;
    }

    // 5개 달성 시 알림 (한 번만 표시)
    if (collectedCount >= 5 && !_hasShown5Reward && _previousCount < 5) {
      _hasShown5Reward = true;
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _showRewardDialog(
            context,
            title: '축하합니다!',
            message: '30% 할인 쿠폰을 받았습니다!',
            reward: '30% 할인 쿠폰',
          );
        }
      });
    }
    
    // 10개 달성 시 알림 (한 번만 표시)
    if (collectedCount >= 10 && !_hasShown10Reward && _previousCount < 10) {
      _hasShown10Reward = true;
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _showRewardDialog(
            context,
            title: '축하합니다!',
            message: '왕복 항공권 1인 2매 쿠폰을 받았습니다!',
            reward: '왕복 항공권 1인 2매',
          );
        }
      });
    }
    
    _previousCount = collectedCount;
  }

  void _showRewardDialog(BuildContext context, {
    required String title,
    required String message,
    required String reward,
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
              onPressed: () {
                Navigator.of(context).pop();
              },
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

    // 테스트 용도: 로그인 없이도 userId 기본값(0)을 사용해 스탬프 개수를 계산
    final int userId = userProvider.userId;
    final int collectedCount =
        stampProvider.getUserStampsByUserId(userId).length;

    // 스탬프 개수 변경 감지 및 보상 확인
    _checkRewards(collectedCount);

    return Scaffold(
      backgroundColor: AeroKColors.white,
      appBar: const AerokTopAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AeroKColors.white,
              const Color(0xFFF5F9FF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 상단 타이틀 - 개선된 디자인 (QR 버튼 포함)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AeroKColors.darkBlue,
                          AeroKColors.darkBlue.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AeroKColors.darkBlue.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Aero Pick!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                            letterSpacing: -0.18,
                            color: AeroKColors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '스탬프를 채우면 혜택을 드려요!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                            letterSpacing: -0.18,
                            color: AeroKColors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 오른쪽 상단 QR 코드 등록 버튼
                  Positioned(
                    top: 8,
                    right: 8,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        foregroundColor: AeroKColors.darkBlue,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                            color: AeroKColors.darkBlue.withOpacity(0.2),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // QR 스캔 화면으로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QrScanScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.qr_code_scanner,
                        size: 18,
                      ),
                      label: const Text(
                        'QR 코드 등록',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // 원형 진행 바와 스탬프 카드 스타일
            Container(
              padding: const EdgeInsets.all(28),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AeroKColors.white,
                    const Color(0xFFF8FBFF),
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AeroKColors.darkBlue.withOpacity(0.15),
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: const Offset(0, 8),
                      ),
                    ],
                  ),
              child: Column(
                children: [
                  // 진행률 표시
                  _buildProgressSection(collectedCount),
                  const SizedBox(height: 32),
                  // 스탬프 현황 (위로 이동)
                  _buildStampPreview(collectedCount),
                  const SizedBox(height: 24),
                  // 스탬프 카드 리스트
                  _buildStampCards(collectedCount),
                ],
              ),
            ),
          ],
            ),
          ),
        ),
      ),
      // Aero Pick! 탭 기준 하단 메뉴 유지
      bottomNavigationBar: const MainBottomNavBar(currentIndex: 1),
    );
  }

  // 진행률 섹션
  static Widget _buildProgressSection(int collectedCount) {
    final progress = collectedCount / 10;
    return Column(
      children: [
        // 원형 진행 바
        SizedBox(
          width: 180,
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 배경 원
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE8F0F7),
                ),
              ),
              // 진행 원
              SizedBox(
                width: 180,
                height: 180,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 12,
                  backgroundColor: const Color(0xFFE8F0F7),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    collectedCount >= 10
                        ? const Color(0xFFFF6B35)
                        : AeroKColors.yellow,
                  ),
                  strokeCap: StrokeCap.round,
                ),
              ),
              // 중앙 텍스트
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$collectedCount',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: AeroKColors.darkBlue,
                      height: 1,
                    ),
                  ),
                  Text(
                    '/ 10',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.darkBlue.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // 진행률 텍스트
        Text(
          '${(progress * 100).toInt()}% 완료',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AeroKColors.darkBlue,
          ),
        ),
      ],
    );
  }

  // 스탬프 카드 리스트
  static Widget _buildStampCards(int collectedCount) {
    return Column(
      children: [
        // 마일스톤 카드 (5번째)
        _buildMilestoneCard(
          index: 5,
          collectedCount: collectedCount,
          title: '30% 달성',
          reward: '30% 할인 쿠폰',
        ),
        const SizedBox(height: 16),
        // 최종 보상 카드 (10번째)
        _buildRewardCard(
          index: 10,
          collectedCount: collectedCount,
          title: '완주 보상',
          reward: '왕복 항공권 1인 2매',
        ),
      ],
    );
  }

  // 스탬프 미리보기 (작은 원형 아이콘들)
  static Widget _buildStampPreview(int collectedCount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AeroKColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8F0F7),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '스탬프 현황',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AeroKColors.darkBlue,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(10, (index) {
              final stampIndex = index + 1;
              final isCollected = stampIndex <= collectedCount;
              return Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: isCollected
                      ? AeroKColors.yellowGradient
                      : null,
                  color: isCollected ? null : const Color(0xFFE8F0F7),
                  shape: BoxShape.circle,
                  border: isCollected
                      ? null
                      : Border.all(
                          color: const Color(0xFFD5E2EF),
                          width: 1,
                        ),
                ),
                child: Center(
                  child: isCollected
                      ? Text(
                          'K',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AeroKColors.darkBlue,
                          ),
                        )
                      : Text(
                          '$stampIndex',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF8CC5FF),
                          ),
                        ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // 마일스톤 카드
  static Widget _buildMilestoneCard({
    required int index,
    required int collectedCount,
    required String title,
    required String reward,
  }) {
    final isCompleted = index <= collectedCount;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isCompleted
              ? [
                  const Color(0xFFB3D9FF),
                  const Color(0xFF8CC5FF),
                ]
              : [
                  const Color(0xFFF0F5FA),
                  const Color(0xFFE8F0F7),
                ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted
              ? const Color(0xFF8CC5FF)
              : const Color(0xFFD5E2EF),
          width: 2,
        ),
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: const Color(0xFF8CC5FF).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // 체크 아이콘 또는 번호
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isCompleted ? Colors.white : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isCompleted
                  ? Icon(
                      Icons.check_circle,
                      color: const Color(0xFF8CC5FF),
                      size: 32,
                    )
                  : Text(
                      '$index',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF8CC5FF),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 16),
          // 텍스트
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isCompleted
                        ? AeroKColors.darkBlue
                        : AeroKColors.darkBlue.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reward,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isCompleted
                        ? AeroKColors.darkBlue.withOpacity(0.8)
                        : AeroKColors.darkBlue.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 최종 보상 카드
  static Widget _buildRewardCard({
    required int index,
    required int collectedCount,
    required String title,
    required String reward,
  }) {
    final isCompleted = index <= collectedCount;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isCompleted
              ? [
                  const Color(0xFFFF8A50),
                  const Color(0xFFFF6B35),
                ]
              : [
                  const Color(0xFFFFF4E6),
                  const Color(0xFFFFE8CC),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isCompleted
              ? const Color(0xFFFF6B35)
              : const Color(0xFFFFD5A3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: (isCompleted
                    ? const Color(0xFFFF6B35)
                    : const Color(0xFFFFD5A3))
                .withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // 숫자 10 또는 체크 아이콘
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(
                          Icons.check_circle,
                          color: const Color(0xFFFF6B35),
                          size: 32,
                        )
                      : Text(
                          '10',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFFF6B35),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              // 텍스트
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: isCompleted
                            ? Colors.white
                            : const Color(0xFFFF6B35),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      reward,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isCompleted
                            ? Colors.white.withOpacity(0.9)
                            : const Color(0xFFFF6B35).withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 격자형 셀 하나 (원형 스탬프 + 텍스트) - 개선된 디자인
class _StampCell extends StatelessWidget {
  final int index;
  final int collectedCount;
  final bool isReward;
  final bool isMilestone;
  final String? labelBelow;

  const _StampCell({
    required this.index,
    required this.collectedCount,
    this.isReward = false,
    this.isMilestone = false,
    this.labelBelow,
  });

  @override
  Widget build(BuildContext context) {
    final double circleSize = 64;

    final bool isCollected = index <= collectedCount;

    Color outerColor;
    Color innerColor;
    List<BoxShadow>? shadows;

    if (isReward) {
      // 보상 스탬프 - 주황색 그라데이션
      outerColor = const Color(0xFFFF6B35);
      innerColor = Colors.white;
      shadows = [
        BoxShadow(
          color: const Color(0xFFFF6B35).withOpacity(0.4),
          blurRadius: 12,
          spreadRadius: 2,
        ),
      ];
    } else if (isCollected) {
      // 수집된 스탬프 - 노란색
      outerColor = AeroKColors.yellow;
      innerColor = Colors.white;
      shadows = [
        BoxShadow(
          color: AeroKColors.yellow.withOpacity(0.3),
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ];
    } else if (isMilestone) {
      // 마일스톤 스탬프 - 연한 파란색 강조
      outerColor = const Color(0xFFB3D9FF);
      innerColor = Colors.white;
    } else {
      // 미수집 스탬프
      outerColor = const Color(0xFFE8F0F7);
      innerColor = Colors.white;
    }

    Widget innerContent;
    if (isCollected) {
      innerContent = Container(
        decoration: BoxDecoration(
          gradient: AeroKColors.yellowGradient,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
        'K',
        style: TextStyle(
          fontFamily: 'Inter',
              fontSize: 24,
          fontWeight: FontWeight.w800,
          height: 1,
          color: AeroKColors.darkBlue,
            ),
          ),
        ),
      );
    } else {
      innerContent = const SizedBox.shrink();
    }

    return SizedBox(
      width: 70,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              gradient: isReward
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFF8A50),
                        const Color(0xFFFF6B35),
                      ],
                    )
                  : isCollected
                      ? AeroKColors.yellowGradient
                      : null,
              color: isReward || isCollected ? null : outerColor,
              shape: BoxShape.circle,
              boxShadow: shadows,
            ),
            child: Center(
              child: Container(
                width: circleSize - 10,
                height: circleSize - 10,
                decoration: BoxDecoration(
                  color: innerColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(child: innerContent),
              ),
            ),
          ),
          if (labelBelow != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isReward
                    ? const Color(0xFFFF6B35).withOpacity(0.1)
                    : isMilestone
                        ? const Color(0xFFB3D9FF).withOpacity(0.3)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
              labelBelow!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                  fontSize: isReward ? 11 : 10,
                  fontWeight: isReward ? FontWeight.w700 : FontWeight.w600,
                height: 1.3,
                  color: isReward
                      ? const Color(0xFFFF6B35)
                      : AeroKColors.darkBlue,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
