import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('지갑 / TTT'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.token, color: Color(0xFF1976D2)),
                  SizedBox(width: 12),
                  Text('누적 토큰(TTT) 수량'),
                  Spacer(),
                  Text('2,340 TTT', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.flag, color: Color(0xFF1976D2)),
                  SizedBox(width: 12),
                  Expanded(child: Text('미션/이벤트 추가 적립 (데모 리스트로 연결 예정)')),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.store, color: Color(0xFF1976D2)),
                  SizedBox(width: 12),
                  Expanded(child: Text('리워드 상점(굿즈/쿠폰/업그레이드)')),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('결제/적립 내역', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('· 2025-11-01 항공권 결제 +1,200 TTT'),
                  Text('· 2025-10-28 이벤트 참여 +300 TTT'),
                  Text('· 2025-10-20 굿즈 교환 -500 TTT'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


