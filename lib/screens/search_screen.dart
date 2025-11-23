import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_provider.dart';
import '../widgets/flight_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int _passengers = 1;

  @override
  void dispose() {
    _departureController.dispose();
    _arrivalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('항공편 검색'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 검색 폼
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 출발지
                  TextField(
                    controller: _departureController,
                    decoration: const InputDecoration(
                      labelText: '출발지',
                      hintText: '예: 서울',
                      prefixIcon: Icon(Icons.flight_takeoff),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 도착지
                  TextField(
                    controller: _arrivalController,
                    decoration: const InputDecoration(
                      labelText: '도착지',
                      hintText: '예: 도쿄',
                      prefixIcon: Icon(Icons.flight_land),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 출발일
                  InkWell(
                    onTap: _selectDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: '출발일',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 승객 수
                  Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(width: 8),
                      const Text('승객 수: '),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _passengers > 1 ? () => setState(() => _passengers--) : null,
                        icon: const Icon(Icons.remove),
                      ),
                      Text('$_passengers'),
                      IconButton(
                        onPressed: () => setState(() => _passengers++),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // 검색 버튼
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _searchFlights,
                      child: const Text('항공편 검색'),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // 검색 결과
            Consumer<FlightProvider>(
              builder: (context, flightProvider, child) {
                if (flightProvider.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                
                if (flightProvider.error.isNotEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        flightProvider.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
                
                if (flightProvider.searchResults.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('검색 조건을 입력하고 검색 버튼을 눌러주세요.'),
                    ),
                  );
                }
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '검색 결과 (${flightProvider.searchResults.length}개)',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: flightProvider.searchResults.length,
                      itemBuilder: (context, index) {
                        final flight = flightProvider.searchResults[index];
                        return FlightCard(
                          flight: flight,
                          onTap: () {
                            _showFlightDetails(context, flight);
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _searchFlights() {
    if (_departureController.text.isEmpty || _arrivalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('출발지와 도착지를 입력해주세요.')),
      );
      return;
    }
    
    final dateString = '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';
    
    context.read<FlightProvider>().searchFlights(
      departure: _departureController.text,
      arrival: _arrivalController.text,
      departureDate: dateString,
      passengers: _passengers,
    );
  }

  void _showFlightDetails(BuildContext context, flight) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${flight.airline} ${flight.flightNumber}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('출발: ${flight.departure} (${flight.departureAirport})'),
            Text('도착: ${flight.arrival} (${flight.arrivalAirport})'),
            Text('시간: ${flight.departureTime} - ${flight.arrivalTime}'),
            Text('소요시간: ${flight.duration}'),
            Text('가격: ${flight.price.toStringAsFixed(0)}원'),
            Text('잔여좌석: ${flight.availableSeats}석'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // 예약 로직 추가
            },
            child: const Text('예약하기'),
          ),
        ],
      ),
    );
  }
}



