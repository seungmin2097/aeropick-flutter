import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';

/// 온라인 결제 안내 화면 (예매 안내)
class OnlinePaymentInfoScreen extends StatelessWidget {
  const OnlinePaymentInfoScreen({super.key});

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
                '예매 안내',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AeroKColors.black,
                ),
              ),
              const SizedBox(height: 32),
              // 고객센터 예매 수수료
              _buildCustomerCenterSection(),
              const SizedBox(height: 32),
              // 현장(공항) 발권 예매 수수료
              _buildAirportSection(),
              const SizedBox(height: 32),
              // 결제 안내
              _buildPaymentInfoSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerCenterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '고객센터 예매 수수료',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AeroKColors.black,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AeroKColors.white,
            border: Border.all(color: AeroKColors.lightGrayBg),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 전화번호
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 20,
                    color: AeroKColors.darkBlue,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '1899-2299',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 운영시간
              Row(
                children: [
                  Text(
                    '운영시간: ',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AeroKColors.black,
                    ),
                  ),
                  Text(
                    '09:00~18:00',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AeroKColors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(한국시간)',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AeroKColors.gray,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 결제방법
              Row(
                children: [
                  Text(
                    '결제방법: ',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AeroKColors.black,
                    ),
                  ),
                  Text(
                    '신용(체크)카드',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AeroKColors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 수수료
              Text(
                '예매 수수료',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AeroKColors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '편도, 승객당(1인당 부과)',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AeroKColors.gray,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AeroKColors.lightGrayBg.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '국내선/국제선',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AeroKColors.black,
                      ),
                    ),
                    Text(
                      '3,000원',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AeroKColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '(해당 수수료는 항공권 취소 시에도 환불 불가(당일 취소 포함))',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AeroKColors.gray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAirportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '현장(공항) 발권 예매 수수료',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AeroKColors.black,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AeroKColors.white,
            border: Border.all(color: AeroKColors.lightGrayBg),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '예매 수수료',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AeroKColors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '편도, 승객당(1인당 부과)',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AeroKColors.gray,
                ),
              ),
              const SizedBox(height: 16),
              // 국내선
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AeroKColors.lightGrayBg.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '국내선',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AeroKColors.black,
                      ),
                    ),
                    Text(
                      '5,000원',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AeroKColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // 국제선
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AeroKColors.lightGrayBg.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '국제선',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AeroKColors.black,
                          ),
                        ),
                        Text(
                          '10,000원',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AeroKColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '(JPY 1,000 / TWD 300)',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AeroKColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '성인/소아(편도 당) 현장 발권 수수료는 출발지 현지 통화로만 지불 가능',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AeroKColors.gray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '결제 안내',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AeroKColors.black,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AeroKColors.white,
            border: Border.all(color: AeroKColors.lightGrayBg),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '신용카드',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AeroKColors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '• 전자상거래 안전성 강화를 위하여 안전결제(ISP), 안심클릭(MPI)을 통한 신용카드 인증 서비스가 실시됩니다.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AeroKColors.black,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '• 카드사 및 결제 금액에 따라 공인인증서가 필수 요구될 수 있습니다.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AeroKColors.black,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '• 23:50 ~ 00:10 사이에는 카드사의 시스템 점검으로 서비스가 중단될 수 있습니다.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AeroKColors.black,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



