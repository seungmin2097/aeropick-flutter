import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/reservation_provider.dart';
import '../models/reservation.dart';
import '../theme/aerok_colors.dart';
import 'login_screen.dart';

class OnlineCheckinScreen extends StatelessWidget {
  const OnlineCheckinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('온라인 체크인'),
      ),
      body: Consumer2<UserProvider, ReservationProvider>(
        builder: (context, userProvider, reservationProvider, child) {
          if (!userProvider.isLoggedIn) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: AeroKColors.darkGray,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '로그인이 필요합니다',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AeroKColors.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '체크인을 하려면 로그인해주세요.',
                    style: TextStyle(color: AeroKColors.darkGray),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text('로그인'),
                  ),
                ],
              ),
            );
          }

          // 체크인 가능한 예약이 있는 경우
          final userReservations = reservationProvider.getReservationsByUserId(userProvider.userId);
          final checkinableReservations = userReservations
              .where((r) => r.reservationStatus == 'confirmed')
              .toList();

          if (checkinableReservations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: AeroKColors.darkGray,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '체크인 가능한 예약이 없습니다',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AeroKColors.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '확인된 예약이 있을 때 체크인이 가능합니다.',
                    style: TextStyle(color: AeroKColors.darkGray),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AeroKColors.yellow.withOpacity(0.1),
                        AeroKColors.lightYellow.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AeroKColors.yellow.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: AeroKColors.yellow.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AeroKColors.yellow.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.info_outline, color: AeroKColors.yellow, size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            '온라인 체크인 안내',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AeroKColors.darkNavy,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '• 출발 24시간 전부터 체크인이 가능합니다',
                        style: TextStyle(color: AeroKColors.darkGray),
                      ),
                      Text(
                        '• 좌석을 선택하고 탑승권을 발급받으세요',
                        style: TextStyle(color: AeroKColors.darkGray),
                      ),
                      Text(
                        '• 체크인 후 QR 코드로 공항에서 바로 탑승하실 수 있습니다',
                        style: TextStyle(color: AeroKColors.darkGray),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '체크인 가능한 예약',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AeroKColors.darkNavy,
                  ),
                ),
                const SizedBox(height: 12),
                ...checkinableReservations.map((reservation) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '예약 #${reservation.reservationId}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AeroKColors.darkNavy,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: AeroKColors.yellowGradient,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AeroKColors.yellow.withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    '체크인 가능',
                                    style: TextStyle(
                                      color: AeroKColors.darkNavy,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '상태: ${reservation.reservationStatus}',
                              style: const TextStyle(color: AeroKColors.darkGray),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  _showCheckinDialog(context, reservation);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AeroKColors.yellow,
                                  foregroundColor: AeroKColors.darkNavy,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  '체크인 하기',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showCheckinDialog(BuildContext context, Reservation reservation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('온라인 체크인'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('예약 번호: #${reservation.reservationId}'),
            Text('상태: ${reservation.reservationStatus}'),
            const SizedBox(height: 16),
            const Text('체크인을 진행하시겠습니까?'),
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('예약 #${reservation.reservationId} 체크인이 완료되었습니다.'),
                ),
              );
            },
            child: const Text('체크인'),
          ),
        ],
      ),
    );
  }
}

