import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';

/// 수수료 및 위약금 안내 화면
class FeeInfoScreen extends StatefulWidget {
  const FeeInfoScreen({super.key});

  @override
  State<FeeInfoScreen> createState() => _FeeInfoScreenState();
}

class _FeeInfoScreenState extends State<FeeInfoScreen> {
  bool _isNoShowFee = false; // false: 수수료 규정, true: 예약 부도 위약금

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
                '수수료 및 위약금 안내',
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
                          _isNoShowFee = false;
                        });
                      },
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: !_isNoShowFee ? AeroKColors.darkBlue : AeroKColors.white,
                          border: Border.all(
                            color: !_isNoShowFee ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '수수료 규정',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: !_isNoShowFee ? AeroKColors.white : AeroKColors.black,
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
                          _isNoShowFee = true;
                        });
                      },
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: _isNoShowFee ? AeroKColors.darkBlue : AeroKColors.white,
                          border: Border.all(
                            color: _isNoShowFee ? AeroKColors.darkBlue : AeroKColors.lightGrayBg,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '예약 부도 위약금',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _isNoShowFee ? AeroKColors.white : AeroKColors.black,
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
              if (_isNoShowFee) ...[
                // 예약 부도 위약금 콘텐츠
                Text(
                  '예약 부도 위약금',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'NO-SHOW에 관련한 위약금 안내입니다.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AeroKColors.black,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                // 적용 대상
                Text(
                  '적용 대상',
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
                    Padding(
                      padding: const EdgeInsets.only(top: 6, right: 8),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AeroKColors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '항공기 탑승 수속 마감 시간까지 항공권(예약) 취소 없이 탑승하지 않거나 탑승 수속 후 탑승하지 않은 승객',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AeroKColors.black,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // 국내선
                Text(
                  '국내선',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AeroKColors.lightGrayBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AeroKColors.lightGrayBg),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plus / Basic / Lite',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AeroKColors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'KRW 15,000',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AeroKColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // 국제선
                Text(
                  '국제선',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AeroKColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AeroKColors.lightGrayBg),
                  ),
                  child: Column(
                    children: [
                      // 테이블 헤더
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '최초 출발 구간',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AeroKColors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '위약금',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AeroKColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      // 한국
                      _buildFeeRow('한국', 'KRW 120,000'),
                      const SizedBox(height: 12),
                      // 일본
                      _buildFeeRow('일본', 'JPY 12,000'),
                      const SizedBox(height: 12),
                      // 중국
                      _buildFeeRow('중국', 'CNY 720'),
                      const SizedBox(height: 12),
                      // 대만
                      _buildFeeRow('대만', 'TWD 3,600'),
                      const SizedBox(height: 12),
                      // 홍콩
                      _buildFeeRow('홍콩', 'HKD 750'),
                      const SizedBox(height: 12),
                      // 몽골·베트남·필리핀
                      _buildFeeRow('몽골·베트남·필리핀', 'USD 120'),
                    ],
                  ),
                ),
              ] else ...[
                // 수수료 규정 콘텐츠
                Text(
                  '항공권 취소 / 환불',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '예약 취소 수수료 및 환불 위약금에 관한 안내입니다.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AeroKColors.black,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                // 환불 규정 섹션
                Text(
                  '환불 규정',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildBulletPoint('취소 수수료는 승객 1인당 편도 기준으로 부과됩니다.'),
                const SizedBox(height: 8),
                _buildBulletPoint('취소 수수료는 최초 예약 시점을 기준으로 적용되며, 취소 시 취소 시점에 따른 \'취소 수수료\'가 부과됩니다.'),
                const SizedBox(height: 8),
                _buildBulletPoint('항공권의 유효 기간은 출발일로부터 1년이며(일부 사용 시 운송 개시일로부터 1년), 환불 가능 기간은 유효기간 종료일로부터 30일입니다.'),
                const SizedBox(height: 8),
                _buildBulletPoint('환불 시 미사용 구간의 유류할증료 및 공항세는 환불 가능합니다.'),
                const SizedBox(height: 8),
                _buildBulletPoint('수수료 총액이 항공권 금액을 초과하는 경우, 추가 징수 없이 공항세 및 유류할증료가 환불됩니다.'),
                const SizedBox(height: 8),
                _buildBulletPoint('왕복 미사용 항공권의 경우, 취소 수수료는 가는 편/오는 편에 각각 적용됩니다.'),
                const SizedBox(height: 8),
                _buildBulletPoint('항공권 최초 예약 완료 이후 24시간 이내 취소 시에는 수수료 없이 환불 가능합니다. 단, 출발 24시간 이내의 항공권을 구매하시는 경우 다음과 같습니다.'),
                const SizedBox(height: 12),
                // 24시간 이내 구매 항공권 환불 기준 테이블
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AeroKColors.lightGrayBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AeroKColors.lightGrayBg),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '구분',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AeroKColors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '국내선',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AeroKColors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '국제선',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AeroKColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '24시간 이내 구매 항공권에 대한 환불 기준(수수료 부과)',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AeroKColors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '출발 시간 20분 이내 취소 시 수수료 면제 불가',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AeroKColors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '출발 시간 60분 이내 취소 시 수수료 면제 불가',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AeroKColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _buildBulletPoint('고객 사정이 아닌 항공기 결함, 기상 등의 이유로 인한 운항 취소의 경우 환불 수수료 부과 없이 환불 가능합니다.'),
                const SizedBox(height: 32),
                // 국내선 취소 수수료 섹션
                Text(
                  '국내선 취소 수수료',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDomesticFeeTable(),
                const SizedBox(height: 32),
                // 국제선 취소 수수료 섹션
                Text(
                  '국제선 취소 수수료 (왕복 예약 시 최초 출발지 기준으로 적용)',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                // 한국 출발 항공편
                Text(
                  '한국 출발 항공편',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInternationalKoreaFeeTable(),
                const SizedBox(height: 24),
                // 해외 출발 항공편
                Text(
                  '해외 출발 항공편',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInternationalOverseasFeeTable(),
                const SizedBox(height: 32),
                // 환불 방법 섹션
                Text(
                  '환불 방법',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AeroKColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildBulletPoint('예매 후 환불을 원하시는 경우에는 최초 결제수단으로 자동 환불 됩니다.'),
                const SizedBox(height: 8),
                _buildBulletPoint('환불 소요 기간은 결제 방법에 따라 차이가 있으며, 취소 후 4~7일 정도 소요됩니다. (영업일 기준)'),
                const SizedBox(height: 8),
                _buildBulletPoint('환불금 입금은 사용한 신용카드 회사의 환불 규정에 따라 차이가 있을 수 있습니다.'),
                const SizedBox(height: 8),
                _buildBulletPoint('충전식 선불 카드의 경우 부분 환불 시 추가 서류 제출이 필요할 수 있습니다.'),
                const SizedBox(height: 8),
                _buildBulletPoint('예약 취소로 인해 수수료가 발생될 경우 해당 수수료가 공제된 금액이 환불됩니다.'),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeeRow(String region, String fee) {
    return Row(
      children: [
        Expanded(
          child: Text(
            region,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AeroKColors.black,
            ),
          ),
        ),
        Expanded(
          child: Text(
            fee,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AeroKColors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6, right: 8),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AeroKColors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AeroKColors.black,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDomesticFeeTable() {
    return Container(
      decoration: BoxDecoration(
        color: AeroKColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AeroKColors.lightGrayBg),
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AeroKColors.lightGrayBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '구분',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Plus',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Basic',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Lite',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildDomesticFeeRow('예약 완료 후 24시간 이내', '무료', '무료', '무료'),
          _buildDomesticFeeRow('예약 완료 24시간 이후 ~ 출발 61일 전', 'KRW 1,000', 'KRW 2,000', 'KRW 3,000'),
          _buildDomesticFeeRow('출발 60일 전 ~ 출발 31일 전', 'KRW 3,000', 'KRW 4,000', 'KRW 5,000'),
          _buildDomesticFeeRow('출발 30일 전 ~ 출발 15일 전', 'KRW 5,000', 'KRW 6,000', 'KRW 7,000'),
          _buildDomesticFeeRow('출발 14일 전 ~ 출발 2일 전', 'KRW 7,000', 'KRW 8,000', 'KRW 9,000'),
          _buildDomesticFeeRow('출발 1일 전 ~ 탑승 수속 마감 전', 'KRW 10,000', 'KRW 11,000', 'KRW 12,000'),
        ],
      ),
    );
  }

  Widget _buildDomesticFeeRow(String category, String plus, String basic, String lite) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AeroKColors.lightGrayBg, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              category,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AeroKColors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              plus,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AeroKColors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              basic,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AeroKColors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              lite,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AeroKColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInternationalKoreaFeeTable() {
    return Container(
      decoration: BoxDecoration(
        color: AeroKColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AeroKColors.lightGrayBg),
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AeroKColors.lightGrayBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '구분',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Plus',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Basic',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Lite',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildDomesticFeeRow('예약 완료 후 24시간 이내', '무료', '무료', '무료'),
          _buildDomesticFeeRow('예약 완료 24시간 이후 ~ 출발 91일 전', '무료', '무료', 'KRW 60,000'),
          _buildDomesticFeeRow('출발 90일 전 ~ 출발 61일 전', 'KRW 10,000', 'KRW 20,000', 'KRW 60,000'),
          _buildDomesticFeeRow('출발 60일 전 ~ 출발 31일 전', 'KRW 20,000', 'KRW 40,000', 'KRW 60,000'),
          _buildDomesticFeeRow('출발 30일 전 ~ 출발 4일 전', 'KRW 40,000', 'KRW 60,000', 'KRW 80,000'),
          _buildDomesticFeeRow('출발 3일 전 ~ 탑승 수속 마감 전', 'KRW 60,000', 'KRW 80,000', 'KRW 100,000'),
        ],
      ),
    );
  }

  Widget _buildInternationalOverseasFeeTable() {
    return Container(
      decoration: BoxDecoration(
        color: AeroKColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AeroKColors.lightGrayBg),
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AeroKColors.lightGrayBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '구분',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Plus',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Basic',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Lite',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AeroKColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildDomesticFeeRow('예약 완료 후 24시간 이내', '무료', '무료', '무료'),
          _buildDomesticFeeRow('일본(JPY) / 탑승 수속 마감 전', 'JPY 3,000', 'JPY 5,000', 'JPY 7,000'),
          _buildDomesticFeeRow('대만(TWD) / 탑승 수속 마감 전', 'TWD 800', 'TWD 1,500', 'TWD 2,100'),
          _buildDomesticFeeRow('중국(CNY) / 탑승 수속 마감 전', 'CNY 180', 'CNY 300', 'CNY 420'),
          _buildDomesticFeeRow('몽골·베트남·필리핀(USD) / 탑승 수속 마감 전', 'USD 30', 'USD 50', 'USD 70'),
        ],
      ),
    );
  }
}

