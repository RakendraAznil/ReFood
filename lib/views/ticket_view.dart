import 'package:flutter/material.dart';
import '../data/app_data.dart';

class TicketView extends StatefulWidget {
  const TicketView({super.key});

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text('Product Detail', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Silahkan tukar kode Booking (Tiket) yang anda miliki di tenant penjual',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: AppData.daftarPesanan.length,
                itemBuilder: (context, index) {
                  final tiket = AppData.daftarPesanan[index];
                  return Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(tiket.idPesanan, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                                  Text(tiket.harga, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(tiket.namaPembeli, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(tiket.lokasiKantin, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                              const Divider(height: 24),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.fastfood, color: Colors.grey),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: tiket.rincianMenu
                                        .map((item) => Text(item, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)))
                                        .toList(),
                                  ),
                                ],
                              ),
                              const Divider(height: 24),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Pick-Up Code', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                      Text(tiket.kodePickup, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20)),
                                    ],
                                  ),
                                  // STATUS PROGRES PENJUALAN
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text('Status Progres', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: tiket.status == "Selesai"
                                              ? Colors.grey[300]
                                              : tiket.status == "Siap Diambil"
                                                  ? Colors.orange[100]
                                                  : Colors.green[100],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          tiket.status,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: tiket.status == "Selesai"
                                                ? Colors.black54
                                                : tiket.status == "Siap Diambil"
                                                    ? Colors.orange[800]
                                                    : Colors.green[800],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      if (tiket.status != "Selesai")
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              setState(() {
                                tiket.status = "Selesai";
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Tiket ${tiket.idPesanan} cocok & pesanan Selesai!'),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: const Text('Verifikasi Cocok & Selesai', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ),

                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}