class Passenger {
  final int passengerId;
  final int fkReservationId;
  final String passengerName;
  final DateTime? birthDate;
  final String? gender;
  final String? nationality;

  Passenger({
    required this.passengerId,
    required this.fkReservationId,
    required this.passengerName,
    this.birthDate,
    this.gender,
    this.nationality,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      passengerId: json['passenger_id'] ?? json['passengerId'] ?? 0,
      fkReservationId: json['fk_reservation_id'] ?? json['fkReservationId'] ?? 0,
      passengerName: json['passenger_name'] ?? json['passengerName'] ?? '',
      birthDate: json['birth_date'] != null || json['birthDate'] != null
          ? DateTime.parse(json['birth_date'] ?? json['birthDate'])
          : null,
      gender: json['gender'],
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passenger_id': passengerId,
      'fk_reservation_id': fkReservationId,
      'passenger_name': passengerName,
      'birth_date': birthDate?.toIso8601String(),
      'gender': gender,
      'nationality': nationality,
    };
  }
}



