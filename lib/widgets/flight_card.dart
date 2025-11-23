import 'package:flutter/material.dart';
import '../models/flight.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;
  final VoidCallback onTap;

  const FlightCard({
    super.key,
    required this.flight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 항공사 및 항공편 번호
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    flight.airline,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    flight.flightNumber,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // 출발/도착 정보
              Row(
                children: [
                  // 출발
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          flight.departureTime,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          flight.departure,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          flight.departureAirport,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // 화살표 아이콘과 소요시간
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF1976D2),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          flight.duration,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // 도착
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          flight.arrivalTime,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          flight.arrival,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          flight.arrivalAirport,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // 가격 및 잔여좌석
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${flight.price.toStringAsFixed(0)}원',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                  Text(
                    '잔여 ${flight.availableSeats}석',
                    style: TextStyle(
                      fontSize: 14,
                      color: flight.availableSeats < 5 ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // 항공기 정보
              Text(
                '${flight.aircraft} • ${flight.departureDate}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
