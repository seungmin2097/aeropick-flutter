import 'package:flutter/foundation.dart';
import '../models/notification.dart';

class NotificationProvider with ChangeNotifier {
  List<Notification> _notifications = [];
  int _nextNotificationId = 1;

  List<Notification> get notifications => _notifications;

  // 사용자별 알림 조회
  List<Notification> getNotificationsByUserId(int userId) {
    return _notifications
        .where((n) => n.fkUserId == userId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // 최신순 정렬
  }

  // 읽지 않은 알림 개수
  int getUnreadCount(int userId) {
    return getNotificationsByUserId(userId).length;
  }

  // 알림 생성
  Future<Notification> createNotification({
    required int userId,
    required String title,
    required String message,
  }) async {
    final notification = Notification(
      notificationId: _nextNotificationId++,
      fkUserId: userId,
      notificationTitle: title,
      notificationMsg: message,
      createdAt: DateTime.now(),
    );
    _notifications.add(notification);
    notifyListeners();
    return notification;
  }

  // 알림 삭제
  void deleteNotification(int notificationId) {
    _notifications.removeWhere((n) => n.notificationId == notificationId);
    notifyListeners();
  }

  // 사용자 알림 모두 삭제
  void clearUserNotifications(int userId) {
    _notifications.removeWhere((n) => n.fkUserId == userId);
    notifyListeners();
  }
}



