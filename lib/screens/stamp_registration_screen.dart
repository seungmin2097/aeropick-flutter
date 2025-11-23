import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';
import 'qr_scan_screen.dart';
import 'stamp_progress_screen.dart';

class StampRegistrationScreen extends StatefulWidget {
  const StampRegistrationScreen({super.key});

  @override
  State<StampRegistrationScreen> createState() => _StampRegistrationScreenState();
}

class _StampRegistrationScreenState extends State<StampRegistrationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
    // 애니메이션 시작
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 가챠 머신 이미지 위치 조정
    const double gachaMachineTop = 150;

    return Scaffold(
      backgroundColor: AeroKColors.white,
      appBar: const AerokTopAppBar(),
      body: Stack(
        children: [
          // 전체 배경
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AeroKColors.lightGrayBg,
          ),
          // 메인 컨텐츠 영역
          Container(
            width: double.infinity,
            height: screenHeight * 0.9,
            color: AeroKColors.white,
          ),
          // 제목: "Aero Pick!"과 "모바일 스탬프 등록"
          Positioned(
            left: 0,
            right: 0,
            top: 60,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Aero Pick!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      height: 35 / 26,
                      letterSpacing: -0.18,
                      color: AeroKColors.darkBlue,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        height: 35 / 26,
                        letterSpacing: -0.18,
                      ),
                      children: [
                        TextSpan(
                          text: '모바일 스탬프',
                          style: TextStyle(color: AeroKColors.yellow),
                        ),
                        TextSpan(
                          text: ' 등록',
                          style: TextStyle(color: AeroKColors.darkBlue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 우측 상단 "나의 스탬프" 버튼 (텍스트와 겹치지 않도록 위치 조정)
          Positioned(
            top: 20,
            right: 16,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                backgroundColor: Colors.white,
                foregroundColor: AeroKColors.darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: AeroKColors.darkBlue.withOpacity(0.2),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StampProgressScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.stars_outlined,
                size: 12,
              ),
              label: const Text(
                '나의 스탬프',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.18,
                ),
              ),
            ),
          ),
          // 가챠 머신 이미지
          Positioned(
            left: (screenWidth - 294) / 2,
            top: gachaMachineTop,
            child: SizedBox(
              width: 294,
              height:
              screenHeight - gachaMachineTop - (screenHeight * 0.35) - 20,
              child: Image.asset(
                'assets/pew1.png',
                width: 294,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 294,
                    decoration: BoxDecoration(
                      color: AeroKColors.lightGrayBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.card_giftcard,
                      size: 150,
                      color: AeroKColors.gray,
                    ),
                  );
                },
              ),
            ),
          ),
          // 하단 네이비 영역 (서서히 나타나는 애니메이션)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.35,
                ),
                color: AeroKColors.darkBlue,
                padding: EdgeInsets.only(
                  left: 32,
                  right: 32,
                  top: 36,
                  bottom: MediaQuery.of(context).padding.bottom + 12,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 설명 텍스트 + QR 작은 아이콘
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Aero Pick!에서 캡슐을 뽑은 후, 굿즈에 있는 QR 코드를 스캔하면 모바일 스탬프가 적립돼요!',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 22 / 16,
                              letterSpacing: -0.18,
                              color: AeroKColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 51,
                          height: 51,
                          decoration: BoxDecoration(
                            color: AeroKColors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.qr_code,
                            size: 40,
                            color: AeroKColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    // QR CODE 스캔하기 버튼
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QrScanScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 281,
                          height: 65.84,
                          decoration: BoxDecoration(
                            color: AeroKColors.white,
                            border: Border.all(
                              color: AeroKColors.darkBlue,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(32.92),
                          ),
                          child: Center(
                            child: Text(
                              'QR CODE 스캔하기',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                height: 22 / 22,
                                letterSpacing: -0.18,
                                color: AeroKColors.darkBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}