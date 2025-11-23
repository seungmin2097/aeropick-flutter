import 'package:flutter/foundation.dart';
import 'dart:math';
import '../models/gacha_item.dart';
import '../models/gacha_draw.dart';

class GachaProvider with ChangeNotifier {
  List<GachaItem> _items = [];
  List<GachaDraw> _draws = [];
  int _nextItemId = 1;
  int _nextDrawId = 1;
  final Random _random = Random();

  List<GachaItem> get items => _items;
  List<GachaDraw> get draws => _draws;

  // 초기화 - 더미 아이템 생성
  void initializeItems() {
    _items = [
      GachaItem(
        itemId: _nextItemId++,
        themeNo: 1,
        itemName: '에어로케이 스티커 세트',
        stockQty: 100,
        imageUrl: null,
      ),
      GachaItem(
        itemId: _nextItemId++,
        themeNo: 1,
        itemName: '비행기 모형',
        stockQty: 50,
        imageUrl: null,
      ),
      GachaItem(
        itemId: _nextItemId++,
        themeNo: 1,
        itemName: '에어로케이 키링',
        stockQty: 200,
        imageUrl: null,
      ),
      GachaItem(
        itemId: _nextItemId++,
        themeNo: 2,
        itemName: '특별 기내식 쿠폰',
        stockQty: 30,
        imageUrl: null,
      ),
      GachaItem(
        itemId: _nextItemId++,
        themeNo: 2,
        itemName: '라운지 이용권',
        stockQty: 20,
        imageUrl: null,
      ),
    ];
    notifyListeners();
  }

  // 테마별 아이템 조회
  List<GachaItem> getItemsByTheme(int themeNo) {
    return _items.where((item) => item.themeNo == themeNo).toList();
  }

  // 사용자별 뽑기 내역 조회
  List<GachaDraw> getDrawsByUserId(int userId) {
    return _draws.where((draw) => draw.fkUserId == userId).toList();
  }

  // 가챠 뽑기 (랜덤)
  Future<GachaDraw?> drawGacha({
    required int userId,
    required int themeNo,
    required int costToken,
  }) async {
    final availableItems = getItemsByTheme(themeNo)
        .where((item) => item.stockQty > 0)
        .toList();

    if (availableItems.isEmpty) {
      return null; // 뽑을 수 있는 아이템이 없음
    }

    // 랜덤으로 아이템 선택
    final selectedItem = availableItems[_random.nextInt(availableItems.length)];

    // 재고 감소
    final itemIndex = _items.indexWhere((item) => item.itemId == selectedItem.itemId);
    if (itemIndex != -1) {
      _items[itemIndex] = GachaItem(
        itemId: _items[itemIndex].itemId,
        themeNo: _items[itemIndex].themeNo,
        itemName: _items[itemIndex].itemName,
        stockQty: _items[itemIndex].stockQty - 1,
        imageUrl: _items[itemIndex].imageUrl,
      );
    }

    // 뽑기 기록 생성
    final draw = GachaDraw(
      drawId: _nextDrawId++,
      fkUserId: userId,
      fkItemId: selectedItem.itemId,
      drawTime: DateTime.now(),
      costToken: costToken,
    );
    _draws.add(draw);
    notifyListeners();

    return draw;
  }

  // 아이템 ID로 아이템 조회
  GachaItem? getItemById(int itemId) {
    try {
      return _items.firstWhere((item) => item.itemId == itemId);
    } catch (e) {
      return null;
    }
  }
}



