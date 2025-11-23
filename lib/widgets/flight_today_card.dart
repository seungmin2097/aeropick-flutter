import 'package:flutter/material.dart';
import '../theme/aerok_colors.dart';

class FlightTodayCard extends StatelessWidget {
  final String routeLabel; // ex) ICN → NRT
  final String departureTime; // ex) 08:35
  final String gate; // ex) A12
  final String status; // ex) Boarding / On Time / Delay

  const FlightTodayCard({
    super.key,
    required this.routeLabel,
    required this.departureTime,
    required this.gate,
    required this.status,
  });

  Color _statusColor() {
    final s = status.toLowerCase();
    if (s.contains('delay')) return Colors.orange;
    if (s.contains('cancel')) return Colors.red;
    return AeroKColors.darkNavy;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AeroKColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AeroKColors.lightGray),
        boxShadow: [
          BoxShadow(
            color: AeroKColors.darkNavy.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                routeLabel,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _statusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: _statusColor(), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.schedule, size: 18),
              const SizedBox(width: 6),
              Text('출발 ${departureTime}')
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.meeting_room, size: 18),
              const SizedBox(width: 6),
              Text('게이트 ${gate}')
            ],
          ),
        ],
      ),
    );
  }
}


