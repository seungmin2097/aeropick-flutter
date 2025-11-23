class UserStamp {
  final int userStampId;
  final int fkUserId;
  final int fkStampLocationId;
  final DateTime scannedAt;

  UserStamp({
    required this.userStampId,
    required this.fkUserId,
    required this.fkStampLocationId,
    required this.scannedAt,
  });

  factory UserStamp.fromJson(Map<String, dynamic> json) {
    return UserStamp(
      userStampId: json['user_stamp_id'] ?? json['userStampId'] ?? 0,
      fkUserId: json['fk_user_id'] ?? json['fkUserId'] ?? 0,
      fkStampLocationId: json['fk_stamp_location_id'] ?? json['fkStampLocationId'] ?? 0,
      scannedAt: json['scanned_at'] != null || json['scannedAt'] != null
          ? DateTime.parse(json['scanned_at'] ?? json['scannedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_stamp_id': userStampId,
      'fk_user_id': fkUserId,
      'fk_stamp_location_id': fkStampLocationId,
      'scanned_at': scannedAt.toIso8601String(),
    };
  }
}



