class Payment {
  final int paymentId;
  final int fkReservationId;
  final int amount;
  final DateTime paidAt;

  Payment({
    required this.paymentId,
    required this.fkReservationId,
    required this.amount,
    required this.paidAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['payment_id'] ?? json['paymentId'] ?? 0,
      fkReservationId: json['fk_reservation_id'] ?? json['fkReservationId'] ?? 0,
      amount: json['amount'] ?? 0,
      paidAt: json['paid_at'] != null || json['paidAt'] != null
          ? DateTime.parse(json['paid_at'] ?? json['paidAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_id': paymentId,
      'fk_reservation_id': fkReservationId,
      'amount': amount,
      'paid_at': paidAt.toIso8601String(),
    };
  }
}



