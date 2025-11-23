class Flight {
  final int flightId;
  final String flightNumber;
  final String departureAirportCode;
  final String arrivalAirportCode;
  final DateTime departureDatetime;
  final DateTime arrivalDatetime;
  final String flightStatus;
  final String aircraftType;
  final DateTime createdAt;
  final double price; // 가격 정보 (실용성을 위해 추가)

  // 편의를 위한 추가 필드 (기존 코드 호환성)
  String get departure => _getCityName(departureAirportCode);
  String get arrival => _getCityName(arrivalAirportCode);
  String get departureTime => _formatTime(departureDatetime);
  String get arrivalTime => _formatTime(arrivalDatetime);
  String get departureDate => _formatDate(departureDatetime);
  String get arrivalDate => _formatDate(arrivalDatetime);
  String get duration => _calculateDuration(departureDatetime, arrivalDatetime);
  String get departureAirport => departureAirportCode;
  String get arrivalAirport => arrivalAirportCode;
  String get id => flightId.toString();
  String get airline => _getAirlineFromFlightNumber(flightNumber);
  String get aircraft => aircraftType;
  int get availableSeats => 50; // 기본값, 실제로는 별도 관리 필요

  Flight({
    required this.flightId,
    required this.flightNumber,
    required this.departureAirportCode,
    required this.arrivalAirportCode,
    required this.departureDatetime,
    required this.arrivalDatetime,
    required this.flightStatus,
    required this.aircraftType,
    required this.createdAt,
    required this.price,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightId: json['flight_id'] ?? json['flightId'] ?? json['id'] ?? 0,
      flightNumber: json['flight_number'] ?? json['flightNumber'] ?? '',
      departureAirportCode: json['departure_airport_code'] ?? 
                            json['departureAirportCode'] ?? 
                            json['departureAirport'] ?? '',
      arrivalAirportCode: json['arrival_airport_code'] ?? 
                         json['arrivalAirportCode'] ?? 
                         json['arrivalAirport'] ?? '',
      departureDatetime: json['departure_datetime'] != null || 
                        json['departureDatetime'] != null
          ? DateTime.parse(json['departure_datetime'] ?? json['departureDatetime'])
          : json['departureDate'] != null && json['departureTime'] != null
              ? DateTime.parse('${json['departureDate']} ${json['departureTime']}')
              : DateTime.now(),
      arrivalDatetime: json['arrival_datetime'] != null || 
                      json['arrivalDatetime'] != null
          ? DateTime.parse(json['arrival_datetime'] ?? json['arrivalDatetime'])
          : json['arrivalDate'] != null && json['arrivalTime'] != null
              ? DateTime.parse('${json['arrivalDate']} ${json['arrivalTime']}')
              : DateTime.now(),
      flightStatus: json['flight_status'] ?? json['flightStatus'] ?? 'scheduled',
      aircraftType: json['aircraft_type'] ?? json['aircraftType'] ?? json['aircraft'] ?? '',
      createdAt: json['created_at'] != null || json['createdAt'] != null
          ? DateTime.parse(json['created_at'] ?? json['createdAt'])
          : DateTime.now(),
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flight_id': flightId,
      'flight_number': flightNumber,
      'departure_airport_code': departureAirportCode,
      'arrival_airport_code': arrivalAirportCode,
      'departure_datetime': departureDatetime.toIso8601String(),
      'arrival_datetime': arrivalDatetime.toIso8601String(),
      'flight_status': flightStatus,
      'aircraft_type': aircraftType,
      'created_at': createdAt.toIso8601String(),
      'price': price,
    };
  }

  // 편의 메서드들
  String _getCityName(String airportCode) {
    final cityMap = {
      'ICN': '서울',
      'GMP': '서울',
      'CJU': '제주',
      'PUS': '부산',
      'NRT': '도쿄',
      'HND': '도쿄',
      'PVG': '상하이',
      'PEK': '베이징',
    };
    return cityMap[airportCode] ?? airportCode;
  }

  String _getAirlineFromFlightNumber(String flightNumber) {
    if (flightNumber.startsWith('KE')) return '대한항공';
    if (flightNumber.startsWith('OZ')) return '아시아나항공';
    if (flightNumber.startsWith('7C')) return '제주항공';
    if (flightNumber.startsWith('LJ')) return '진에어';
    return '에어로케이';
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  String _calculateDuration(DateTime departure, DateTime arrival) {
    final duration = arrival.difference(departure);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0 && minutes > 0) {
      return '${hours}시간 ${minutes}분';
    } else if (hours > 0) {
      return '${hours}시간';
    } else {
      return '${minutes}분';
    }
  }
}

