class Booking {
  final String id;
  final String flightId;
  final String passengerName;
  final String passengerEmail;
  final String passengerPhone;
  final String seatNumber;
  final String bookingDate;
  final String status;
  final double totalPrice;
  final String bookingReference;
  final List<String> passengers;

  Booking({
    required this.id,
    required this.flightId,
    required this.passengerName,
    required this.passengerEmail,
    required this.passengerPhone,
    required this.seatNumber,
    required this.bookingDate,
    required this.status,
    required this.totalPrice,
    required this.bookingReference,
    required this.passengers,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      flightId: json['flightId'] ?? '',
      passengerName: json['passengerName'] ?? '',
      passengerEmail: json['passengerEmail'] ?? '',
      passengerPhone: json['passengerPhone'] ?? '',
      seatNumber: json['seatNumber'] ?? '',
      bookingDate: json['bookingDate'] ?? '',
      status: json['status'] ?? '',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      bookingReference: json['bookingReference'] ?? '',
      passengers: List<String>.from(json['passengers'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flightId': flightId,
      'passengerName': passengerName,
      'passengerEmail': passengerEmail,
      'passengerPhone': passengerPhone,
      'seatNumber': seatNumber,
      'bookingDate': bookingDate,
      'status': status,
      'totalPrice': totalPrice,
      'bookingReference': bookingReference,
      'passengers': passengers,
    };
  }
}

