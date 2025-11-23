import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/reservation_provider.dart';
import '../models/reservation.dart';
import '../theme/aerok_colors.dart';
import 'login_screen.dart';

class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('나의 예약'),
      ),
      body: Consumer2<UserProvider, ReservationProvider>(
        builder: (context, userProvider, reservationProvider, child) {
          if (!userProvider.isLoggedIn) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.flight,
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
                    '예약을 확인하려면 로그인해주세요.',
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

          final userReservations = reservationProvider.getReservationsByUserId(userProvider.userId);
          
          if (userReservations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.flight,
                    size: 80,
                    color: AeroKColors.darkGray,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '예약 내역이 없습니다',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AeroKColors.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '새로운 항공편을 검색해보세요.',
                    style: TextStyle(color: AeroKColors.darkGray),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: userReservations.length,
            itemBuilder: (context, index) {
              final reservation = userReservations[index];
              return ReservationCard(
                reservation: reservation,
                onTap: () => _showReservationDetails(context, reservation, reservationProvider),
                onCancel: () => _cancelReservation(context, reservation, reservationProvider),
              );
            },
          );
        },
      ),
    );
  }

  void _showReservationDetails(BuildContext context, Reservation reservation, ReservationProvider reservationProvider) {
    final passengers = reservationProvider.passengers.where((p) => p.fkReservationId == reservation.reservationId).toList();
    final payments = reservationProvider.payments.where((p) => p.fkReservationId == reservation.reservationId).toList();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('예약 상세 - #${reservation.reservationId}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('예약 번호: #${reservation.reservationId}'),
              Text('상태: ${reservation.reservationStatus}'),
              if (passengers.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text('승객:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...passengers.map((p) => Text('  • ${p.passengerName}')),
              ],
              if (payments.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text('결제:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...payments.map((p) => Text('  • ${p.amount.toStringAsFixed(0)}원 (${p.paidAt.toString().substring(0, 10)})')),
              ],
            ],
          ),
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

  void _cancelReservation(BuildContext context, Reservation reservation, ReservationProvider reservationProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('예약 취소'),
        content: const Text('정말로 이 예약을 취소하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('아니오'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              reservationProvider.cancelReservation(reservation.reservationId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('예약이 취소되었습니다.')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('예, 취소합니다'),
          ),
        ],
      ),
    );
  }
}

class ReservationCard extends StatelessWidget {
  final Reservation reservation;
  final VoidCallback onTap;
  final VoidCallback onCancel;

  const ReservationCard({
    super.key,
    required this.reservation,
    required this.onTap,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
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
                      color: _getStatusColor(reservation.reservationStatus),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      reservation.reservationStatus,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onCancel,
                    child: const Text(
                      '취소',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

