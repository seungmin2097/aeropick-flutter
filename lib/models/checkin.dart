class Checkin {
  final int checkinId;
  final int fkTicketId;
  final DateTime checkinTime;
  final String checkinChannel;
  final String? seatNo;

  Checkin({
    required this.checkinId,
    required this.fkTicketId,
    required this.checkinTime,
    required this.checkinChannel,
    this.seatNo,
  });

  factory Checkin.fromJson(Map<String, dynamic> json) {
    return Checkin(
      checkinId: json['checkin_id'] ?? json['checkinId'] ?? 0,
      fkTicketId: json['fk_ticket_id'] ?? json['fkTicketId'] ?? 0,
      checkinTime: json['checkin_time'] != null || json['checkinTime'] != null
          ? DateTime.parse(json['checkin_time'] ?? json['checkinTime'])
          : DateTime.now(),
      checkinChannel: json['checkin_channel'] ?? json['checkinChannel'] ?? 'online',
      seatNo: json['seat_no'] ?? json['seatNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkin_id': checkinId,
      'fk_ticket_id': fkTicketId,
      'checkin_time': checkinTime.toIso8601String(),
      'checkin_channel': checkinChannel,
      'seat_no': seatNo,
    };
  }
}



