class StampLocation {
  final int stampLocationId;
  final String locationName;
  final String? locationDesc;
  final String qrCodeValue;

  StampLocation({
    required this.stampLocationId,
    required this.locationName,
    this.locationDesc,
    required this.qrCodeValue,
  });

  factory StampLocation.fromJson(Map<String, dynamic> json) {
    return StampLocation(
      stampLocationId: json['stamp_location_id'] ?? json['stampLocationId'] ?? 0,
      locationName: json['location_name'] ?? json['locationName'] ?? '',
      locationDesc: json['location_desc'] ?? json['locationDesc'],
      qrCodeValue: json['qr_code_value'] ?? json['qrCodeValue'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stamp_location_id': stampLocationId,
      'location_name': locationName,
      'location_desc': locationDesc,
      'qr_code_value': qrCodeValue,
    };
  }
}



