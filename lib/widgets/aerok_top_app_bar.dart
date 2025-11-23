import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';
import 'aerok_logo.dart';
import '../screens/login_screen.dart';
import '../screens/menu_screen.dart';

/// 앱 상단에 공통으로 사용하는 Aero_K AppBar
class AerokTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AerokTopAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _openMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MenuScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AeroKColors.darkBlue,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AeroKColors.white),
        onPressed: () => _openMenu(context),
      ),
      centerTitle: true,
      title: const AeroKLogo(width: 140, height: 30, useDarkText: false),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined,
              color: AeroKColors.white),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('알림 기능 준비 중')),
            );
          },
          tooltip: '알림',
        ),
        IconButton(
          icon:
              const Icon(Icons.person_outline, color: AeroKColors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          tooltip: '마이페이지',
        ),
      ],
    );
  }
}


