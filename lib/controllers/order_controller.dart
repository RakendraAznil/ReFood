
import '../models/order_model.dart';

class OrderController {
  static final List<OrderModel> _orders = [];

  static List<OrderModel> get orders {
    return List.unmodifiable(_orders);
  }

  static void addOrder(OrderModel order) {
    _orders.add(order);
  }

  static List<OrderModel> getOrdersByCustomer(String customerName) {
    return _orders
        .where((order) => order.customerName == customerName)
        .toList()
        .reversed
        .toList();
  }
}
