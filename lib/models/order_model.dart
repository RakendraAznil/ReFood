
import 'makanan_model.dart';

class OrderModel {
  final String orderId;
  final String bookingCode;
  final Makanan makanan;
  final String customerName;
  final int quantity;
  final int price;
  final DateTime orderDate;
  final String pickupTime;
  final String pickupLocation;
  String status;

  OrderModel({
    required this.orderId,
    required this.bookingCode,
    required this.makanan,
    required this.customerName,
    required this.quantity,
    required this.price,
    required this.orderDate,
    required this.pickupTime,
    required this.pickupLocation,
    this.status = 'Menunggu Pengambilan',
  });

  int get totalPrice => quantity * price;

  String get foodName => makanan.nama;

  String get tenantName => makanan.kantin;
}
