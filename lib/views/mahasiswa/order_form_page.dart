import '../../controllers/order_controller.dart';
import 'package:flutter/material.dart';

import '../../models/makanan_model.dart';
import '../../models/order_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/format_currency.dart';
import 'digital_ticket_page.dart';

class OrderFormPage extends StatefulWidget {
  final Makanan makanan;
  final String customerName;

  const OrderFormPage({
    super.key,
    required this.makanan,
    required this.customerName,
  });

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  int quantity = 1;

  int get price {
    final harga = widget.makanan.hargaDiskon;
    final angka = harga.replaceAll(RegExp(r'[^0-9]'), '');

    return int.tryParse(angka) ?? 0;
  }

  int get totalPrice => quantity * price;

  void increaseQuantity() {
    if (quantity < widget.makanan.stok) {
      setState(() {
        quantity++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jumlah pesanan melebihi stok tersedia'),
        ),
      );
    }
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void confirmOrder() {
    if (widget.makanan.stok <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Stok makanan sudah habis'),
        ),
      );
      return;
    }

    final now = DateTime.now();

    final order = OrderModel(
      orderId: 'ORD-${now.millisecondsSinceEpoch}',
      bookingCode: 'RF${now.millisecondsSinceEpoch % 100000}',
      makanan: widget.makanan,
      customerName: widget.customerName,
      quantity: quantity,
      price: price,
      orderDate: now,
      pickupTime: 'Sesuai jadwal tenant',
      pickupLocation: widget.makanan.kantin,
    );

    OrderController.addOrder(order);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DigitalTicketPage(
          order: order,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundApp,
      appBar: AppBar(
        title: const Text(
          'Form Pemesanan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
        backgroundColor: AppColors.backgroundApp,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.textBlack,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Makanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: widget.makanan.warnaBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.makanan.icon,
                      size: 38,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.makanan.nama,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textBlack,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.makanan.kantin,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textGray,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          FormatCurrency.rupiah(price),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Informasi Pembeli',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nama Pembeli',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textGray,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.customerName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Jumlah Pesanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jumlah Makanan',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Stok tersedia: ${widget.makanan.stok}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textGray,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: decreaseQuantity,
                        icon: const Icon(Icons.remove_circle_outline),
                        color: AppColors.primary,
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: increaseQuantity,
                        icon: const Icon(Icons.add_circle),
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Informasi Pengambilan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lokasi Pengambilan',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textGray,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.makanan.kantin,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlack,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Waktu mengikuti jadwal tenant',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Harga Satuan',
                        style: TextStyle(
                          color: AppColors.textGray,
                        ),
                      ),
                      Text(FormatCurrency.rupiah(price)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jumlah',
                        style: TextStyle(
                          color: AppColors.textGray,
                        ),
                      ),
                      Text('$quantity'),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                      Text(
                        FormatCurrency.rupiah(totalPrice),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: widget.makanan.stok > 0
                    ? confirmOrder
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.softGray,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Konfirmasi Pesanan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
