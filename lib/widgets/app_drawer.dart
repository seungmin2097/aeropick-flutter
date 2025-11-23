import 'package:flutter/material.dart';
import '../widgets/aerok_logo.dart';
import '../theme/aerok_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: AeroKColors.primaryGradient,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                AeroKLogo(width: 180, height: 38),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.airplanemode_active, color: AeroKColors.darkNavy),
            title: const Text('항공정보/운항/혼잡도'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.map, color: AeroKColors.darkNavy),
            title: const Text('공항 동선도/안내'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.local_taxi, color: AeroKColors.darkNavy),
            title: const Text('여행 티켓/패스/대여·귀국'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.devices_other, color: AeroKColors.darkNavy),
            title: const Text('다양한 연결/공유'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.support_agent, color: AeroKColors.darkNavy),
            title: const Text('고객센터 / 1:1 문의 / FAQ'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: AeroKColors.darkNavy),
            title: const Text('Aero-K 소개 / 공지 / 이벤트'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AeroKColors.yellow.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.stars, color: AeroKColors.yellow, size: 20),
            ),
            title: const Text(
              '특별 혜택',
              style: TextStyle(fontWeight: FontWeight.bold, color: AeroKColors.darkNavy),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}


