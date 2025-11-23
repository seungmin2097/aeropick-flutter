import 'package:flutter/material.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: const [
                CircleAvatar(child: Icon(Icons.person)),
                SizedBox(width: 12),
                Expanded(child: Text('프로필 / 등급 / 뱃지')),
                Icon(Icons.chevron_right),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('나의 비행기록/예약내역', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('· 2025-11-15 ICN → NRT (예약 완료)'),
                Text('· 2025-09-20 ICN → CJU (탑승 완료)'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: const [
                Icon(Icons.notifications_none, color: Color(0xFF1976D2)),
                SizedBox(width: 12),
                Expanded(child: Text('알림센터')),
                Icon(Icons.chevron_right),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: const [
                Icon(Icons.settings_outlined, color: Color(0xFF1976D2)),
                SizedBox(width: 12),
                Expanded(child: Text('설정 (푸시/언어/테마)')),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


