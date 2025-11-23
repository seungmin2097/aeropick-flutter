class Ticket {
  final int ticketId;
  final int fkPassengerId;
  final int fkFlightId;
  final String? seatNo;
  final String ticketStatus;
  final DateTime issuedAt;

  Ticket({
    required this.ticketId,
    required this.fkPassengerId,
    required this.fkFlightId,
    this.seatNo,
    required this.ticketStatus,
    required this.issuedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      ticketId: json['ticket_id'] ?? json['ticketId'] ?? 0,
      fkPassengerId: json['fk_passenger_id'] ?? json['fkPassengerId'] ?? 0,
      fkFlightId: json['fk_flight_id'] ?? json['fkFlightId'] ?? 0,
      seatNo: json['seat_no'] ?? json['seatNo'],
      ticketStatus: json['ticket_status'] ?? json['ticketStatus'] ?? 'issued',
      issuedAt: json['issued_at'] != null || json['issuedAt'] != null
          ? DateTime.parse(json['issued_at'] ?? json['issuedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticket_id': ticketId,
      'fk_passenger_id': fkPassengerId,
      'fk_flight_id': fkFlightId,
      'seat_no': seatNo,
      'ticket_status': ticketStatus,
      'issued_at': issuedAt.toIso8601String(),
    };
  }
}



