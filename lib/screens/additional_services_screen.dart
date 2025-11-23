import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import '../widgets/aerok_top_app_bar.dart';

/// 부가서비스 안내 화면
class AdditionalServicesScreen extends StatelessWidget {
  const AdditionalServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AeroKColors.white,
      appBar: const AerokTopAppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;
            final padding = 40.0; // 좌우 패딩
            final availableWidth = screenWidth - padding;
            final cardWidth = (availableWidth - 16) / 2; // 간격 제외한 카드 너비
            
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목
                  Text(
                    '부가서비스 안내',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AeroKColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 부제목
                  Text(
                    '부가서비스를 구매하고 더 편안한 여행을 계획하세요',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AeroKColors.gray,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 서비스 그리드
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, gridConstraints) {
                        final availableHeight = gridConstraints.maxHeight;
                        final cardHeight = (availableHeight - 16) / 2; // 간격 제외한 카드 높이
                        final childAspectRatio = cardWidth / cardHeight;
                        
                        return GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: childAspectRatio,
                          children: [
                  _buildServiceCard(
                    context,
                    icon: Icons.event_seat,
                    title: '기내 좌석 구매',
                    infoTitle: '기내 좌석 안내',
                    onInfoTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('기내 좌석 안내 기능 준비 중')),
                      );
                    },
                    onPurchaseTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('기내 좌석 구매 기능 준비 중')),
                      );
                    },
                  ),
                  _buildServiceCard(
                    context,
                    icon: Icons.luggage,
                    title: '사전 수하물 추가',
                    infoTitle: '사전 수하물 안내',
                    onInfoTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('사전 수하물 안내 기능 준비 중')),
                      );
                    },
                    onPurchaseTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('사전 수하물 구매 기능 준비 중')),
                      );
                    },
                  ),
                  _buildServiceCard(
                    context,
                    icon: Icons.restaurant,
                    title: '사전 주문 기내식',
                    infoTitle: '사전 주문 기내식 안내',
                    onInfoTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('사전 주문 기내식 안내 기능 준비 중')),
                      );
                    },
                    onPurchaseTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('사전 주문 기내식 구매 기능 준비 중')),
                      );
                    },
                  ),
                  _buildServiceCard(
                    context,
                    icon: Icons.pets,
                    title: '반려동물 동반 신청',
                    infoTitle: '반려동물 동반 안내',
                    onInfoTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('반려동물 동반 안내 기능 준비 중')),
                      );
                    },
                    onPurchaseTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('반려동물 동반 신청 기능 준비 중')),
                      );
                    },
                  ),
                ],
                          );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String infoTitle,
    required VoidCallback onInfoTap,
    required VoidCallback onPurchaseTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AeroKColors.lightGrayBg.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 아이콘
          Icon(
            icon,
            size: 40,
            color: AeroKColors.darkBlue,
          ),
          const SizedBox(height: 8),
          // 제목
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AeroKColors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          // 버튼들
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onInfoTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AeroKColors.white,
                    foregroundColor: AeroKColors.darkBlue,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: AeroKColors.darkBlue, width: 1),
                    ),
                    elevation: 0,
                    minimumSize: const Size(0, 36),
                  ),
                  child: Text(
                    infoTitle,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: ElevatedButton(
                  onPressed: onPurchaseTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AeroKColors.darkBlue,
                    foregroundColor: AeroKColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    minimumSize: const Size(0, 36),
                  ),
                  child: Text(
                    '구매하기',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

