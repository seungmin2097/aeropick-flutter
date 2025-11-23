import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';

/// 운임 안내 화면
class FareInfoScreen extends StatefulWidget {
  const FareInfoScreen({super.key});

  @override
  State<FareInfoScreen> createState() => _FareInfoScreenState();
}

class _FareInfoScreenState extends State<FareInfoScreen> {
  bool _isInternational = false; // false: 국내선, true: 국제선

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
                '운임 안내',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AeroKColors.darkBlue,
                ),
              ),
              const SizedBox(height: 24),
              // 국내선/국제선 탭
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isInternational = false;
                        });
                      },
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: !_isInternational ? AeroKColors.darkBlue : AeroKColors.white,
                          border: Border.all(
                            color: !_isInternational ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '국내선',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: !_isInternational ? AeroKColors.white : AeroKColors.black,
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
                          _isInternational = true;
                        });
                      },
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: _isInternational ? AeroKColors.darkBlue : AeroKColors.white,
                          border: Border.all(
                            color: _isInternational ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '국제선',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _isInternational ? AeroKColors.white : AeroKColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // 국내선/국제선 콘텐츠
              if (_isInternational) ...[
                // 국제선 콘텐츠
                Text(
                  '국제선 공시운임 안내',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '운임표 금액은 성인 기준의 편도 운임입니다. 운임 금액은 사전 고지 없이 변동될 수 있습니다. 할인 운임(Basic, Lite)은 예매 단계에서 확인하실 수 있습니다.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AeroKColors.black,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                // 국제선 일반운임표 버튼
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AeroKColors.white,
                    border: Border.all(color: AeroKColors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // 국제선 일반운임표 화면으로 이동 (추후 구현)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('국제선 일반운임표 기능 준비 중'),
                        ),
                      );
                    },
                    child: Text(
                      '국제선 일반운임표',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AeroKColors.black,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                // 국내선 콘텐츠
                Text(
                  '국내선 공시운임 안내',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '운임표 금액은 성인 기준의 편도 운임입니다. 운임 금액은 사전 고지 없이 변동될 수 있습니다. 할인 운임(Basic, Lite)은 예매 단계에서 확인하실 수 있습니다.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AeroKColors.black,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                // 국내선 일반운임표 버튼
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AeroKColors.white,
                    border: Border.all(color: AeroKColors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // 국내선 일반운임표 화면으로 이동 (추후 구현)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('국내선 일반운임표 기능 준비 중'),
                        ),
                      );
                    },
                    child: Text(
                      '국내선 일반운임표',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AeroKColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

