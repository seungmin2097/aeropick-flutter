class GachaItem {
  final int itemId;
  final int themeNo;
  final String itemName;
  final int stockQty;
  final String? imageUrl;

  GachaItem({
    required this.itemId,
    required this.themeNo,
    required this.itemName,
    required this.stockQty,
    this.imageUrl,
  });

  factory GachaItem.fromJson(Map<String, dynamic> json) {
    return GachaItem(
      itemId: json['item_id'] ?? json['itemId'] ?? 0,
      themeNo: json['theme_no'] ?? json['themeNo'] ?? 0,
      itemName: json['item_name'] ?? json['itemName'] ?? '',
      stockQty: json['stock_qty'] ?? json['stockQty'] ?? 0,
      imageUrl: json['image_url'] ?? json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'theme_no': themeNo,
      'item_name': itemName,
      'stock_qty': stockQty,
      'image_url': imageUrl,
    };
  }
}



