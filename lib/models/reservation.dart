class Reservation {
  final int reservationId;
  final int fkUserId;
  final String reservationStatus;

  Reservation({
    required this.reservationId,
    required this.fkUserId,
    required this.reservationStatus,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json['reservation_id'] ?? json['reservationId'] ?? 0,
      fkUserId: json['fk_user_id'] ?? json['fkUserId'] ?? 0,
      reservationStatus: json['reservation_status'] ?? json['reservationStatus'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservation_id': reservationId,
      'fk_user_id': fkUserId,
      'reservation_status': reservationStatus,
    };
  }
}



