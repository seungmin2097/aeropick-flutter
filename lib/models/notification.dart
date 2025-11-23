class Notification {
  final int notificationId;
  final int fkUserId;
  final String notificationTitle;
  final String notificationMsg;
  final DateTime createdAt;

  Notification({
    required this.notificationId,
    required this.fkUserId,
    required this.notificationTitle,
    required this.notificationMsg,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      notificationId: json['notification_id'] ?? json['notificationId'] ?? 0,
      fkUserId: json['fk_user_id'] ?? json['fkUserId'] ?? 0,
      notificationTitle: json['notification_title'] ?? json['notificationTitle'] ?? '',
      notificationMsg: json['notification_msg'] ?? json['notificationMsg'] ?? '',
      createdAt: json['created_at'] != null || json['createdAt'] != null
          ? DateTime.parse(json['created_at'] ?? json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification_id': notificationId,
      'fk_user_id': fkUserId,
      'notification_title': notificationTitle,
      'notification_msg': notificationMsg,
      'created_at': createdAt.toIso8601String(),
    };
  }
}



