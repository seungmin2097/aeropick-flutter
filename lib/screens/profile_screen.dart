import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/reservation_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: Consumer2<UserProvider, ReservationProvider>(
        builder: (context, userProvider, reservationProvider, child) {
          if (!userProvider.isLoggedIn) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '로그인이 필요합니다',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '프로필을 확인하려면 로그인해주세요.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      _showLoginDialog(context);
                    },
                    child: const Text('로그인'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 프로필 정보 카드
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xFF1976D2),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          userProvider.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userProvider.email,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userProvider.phone,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // 메뉴 옵션들
                _buildMenuOption(
                  icon: Icons.flight,
                  title: '내 예약',
                  subtitle: '${reservationProvider.getReservationsByUserId(userProvider.userId).length}개의 예약',
                  onTap: () {
                    // 예약 화면으로 이동
                    DefaultTabController.of(context)?.animateTo(2);
                  },
                ),
                
                _buildMenuOption(
                  icon: Icons.settings,
                  title: '설정',
                  subtitle: '앱 설정 및 환경설정',
                  onTap: () {
                    _showSettingsDialog(context);
                  },
                ),
                
                _buildMenuOption(
                  icon: Icons.help,
                  title: '고객지원',
                  subtitle: '도움말 및 문의',
                  onTap: () {
                    _showHelpDialog(context);
                  },
                ),
                
                _buildMenuOption(
                  icon: Icons.info,
                  title: '앱 정보',
                  subtitle: '버전 1.0.0',
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
                
                const SizedBox(height: 20),
                
                // 로그아웃 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('로그아웃'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1976D2)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그인'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<UserProvider>().login(
                emailController.text,
                passwordController.text,
              );
            },
            child: const Text('로그인'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말로 로그아웃하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<UserProvider>().logout();
            },
            child: const Text('로그아웃'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('설정'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('알림 설정'),
              trailing: Switch(value: true, onChanged: null),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('언어'),
              trailing: Text('한국어'),
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('다크 모드'),
              trailing: Switch(value: false, onChanged: null),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('고객지원'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('자주 묻는 질문'),
            SizedBox(height: 8),
            Text('• 예약은 어떻게 하나요?'),
            Text('• 예약을 취소하려면?'),
            Text('• 비행기표를 변경하려면?'),
            SizedBox(height: 16),
            Text('문의하기'),
            SizedBox(height: 8),
            Text('이메일: support@airline.com'),
            Text('전화: 1588-0000'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('앱 정보'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('항공 예약 앱'),
            SizedBox(height: 8),
            Text('버전: 1.0.0'),
            SizedBox(height: 8),
            Text('Flutter로 개발된 항공 예약 애플리케이션입니다.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }
}

