class GachaDraw {
  final int drawId;
  final int fkUserId;
  final int fkItemId;
  final DateTime drawTime;
  final int costToken;

  GachaDraw({
    required this.drawId,
    required this.fkUserId,
    required this.fkItemId,
    required this.drawTime,
    required this.costToken,
  });

  factory GachaDraw.fromJson(Map<String, dynamic> json) {
    return GachaDraw(
      drawId: json['draw_id'] ?? json['drawId'] ?? 0,
      fkUserId: json['fk_user_id'] ?? json['fkUserId'] ?? 0,
      fkItemId: json['fk_item_id'] ?? json['fkItemId'] ?? 0,
      drawTime: json['draw_time'] != null || json['drawTime'] != null
          ? DateTime.parse(json['draw_time'] ?? json['drawTime'])
          : DateTime.now(),
      costToken: json['cost_token'] ?? json['costToken'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'draw_id': drawId,
      'fk_user_id': fkUserId,
      'fk_item_id': fkItemId,
      'draw_time': drawTime.toIso8601String(),
      'cost_token': costToken,
    };
  }
}



