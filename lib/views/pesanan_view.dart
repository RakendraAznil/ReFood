import 'package:flutter/material.dart';
import '../data/app_data.dart';

class PesananView extends StatefulWidget {
  const PesananView({super.key});

  @override
  State<PesananView> createState() => _PesananViewState();
}

class _PesananViewState extends State<PesananView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ReFood', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20)),
            Text('Kenyang Hemat, Bumi Selamat', style: TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hasil Jualan Kamu Hari Ini', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Rp250.000', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            ...AppData.daftarPesanan.map((pesanan) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                color: Colors.white,
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(pesanan.idPesanan, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                          Text(pesanan.harga, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(pesanan.namaPembeli, style: const TextStyle(color: Colors.grey)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: pesanan.status == "Selesai"
                                  ? Colors.grey[300]
                                  : pesanan.status == "Siap Diambil"
                                      ? Colors.orange[100]
                                      : Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              pesanan.status,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: pesanan.status == "Selesai"
                                    ? Colors.black54
                                    : pesanan.status == "Siap Diambil"
                                        ? Colors.orange[800]
                                        : Colors.green[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      
                      Text(pesanan.namaMakanan, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 8),
                      Text('Pick-Up Code: ${pesanan.kodePickup}', style: const TextStyle(color: Colors.black54)),
                      
                      const SizedBox(height: 16),
                      
                      if (pesanan.status != "Selesai")
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {
                              setState(() {
                                if (pesanan.status == "Diproses") {
                                  pesanan.status = "Siap Diambil";
                                } else if (pesanan.status == "Siap Diambil") {
                                  pesanan.status = "Selesai";
                                }
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Status ${pesanan.idPesanan} diubah jadi: ${pesanan.status}'),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Text(
                              pesanan.status == "Diproses" ? 'Scan Barcode (Siapkan)' : 'Selesaikan Pesanan',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}