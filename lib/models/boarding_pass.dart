class BoardingPass {
  final int boardingPassId;
  final int fkCheckinId;
  final String qrCodeValue;
  final DateTime issuedAt;

  BoardingPass({
    required this.boardingPassId,
    required this.fkCheckinId,
    required this.qrCodeValue,
    required this.issuedAt,
  });

  factory BoardingPass.fromJson(Map<String, dynamic> json) {
    return BoardingPass(
      boardingPassId: json['boarding_pass_id'] ?? json['boardingPassId'] ?? 0,
      fkCheckinId: json['fk_checkin_id'] ?? json['fkCheckinId'] ?? 0,
      qrCodeValue: json['qr_code_value'] ?? json['qrCodeValue'] ?? '',
      issuedAt: json['issued_at'] != null || json['issuedAt'] != null
          ? DateTime.parse(json['issued_at'] ?? json['issuedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'boarding_pass_id': boardingPassId,
      'fk_checkin_id': fkCheckinId,
      'qr_code_value': qrCodeValue,
      'issued_at': issuedAt.toIso8601String(),
    };
  }
}



