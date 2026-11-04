import 'package:flutter/foundation.dart';

import '../models/tenant_food.dart';

class TenantCatalogController extends ChangeNotifier {
  final List<TenantFood> foods = <TenantFood>[];
  int _nextId = 1;

  int get totalSalesToday => 0;

  void addFood({required String name, required int price, required int stock}) {
    foods.add(
      TenantFood(id: _nextId++, name: name.trim(), price: price, stock: stock),
    );
    notifyListeners();
  }

  void updateFood(
    int id, {
    required String name,
    required int price,
    required int stock,
  }) {
    final index = foods.indexWhere((food) => food.id == id);
    if (index == -1) return;

    foods[index] = foods[index].copyWith(
      name: name.trim(),
      price: price,
      stock: stock,
    );
    notifyListeners();
  }

  void removeFood(int id) {
    foods.removeWhere((food) => food.id == id);
    notifyListeners();
  }
}
