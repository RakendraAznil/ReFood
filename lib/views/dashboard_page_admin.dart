import 'package:flutter/material.dart';

import '../controllers/dashboard_controller_admin.dart';
import '../utils/app_colors.dart';
import 'widgets/admin/header_dashboard.dart';
import 'widgets/admin/kartu_info.dart';
import 'widgets/admin/status_pesanan.dart';
import 'widgets/admin/item_makanan.dart';

class DashboardPage extends StatelessWidget {
  // panggil controller
  final DashboardController controller = DashboardController();

  @override
  Widget build(BuildContext context) {
    var stat = controller.statistik;

    return Scaffold(
      backgroundColor: AppColors.backgroundApp,
      body: SafeArea(
        child: Column(
          children: [
            // header
            HeaderDashboard(),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // dua kartu atas
                    Row(
                      children: [
                        Expanded(
                          child: KartuInfo(
                            judul: 'Stok Makanan',
                            angka: '${stat.stokMakanan}',
                            satuan: 'Porsi',
                            keterangan: '${stat.menuAktif} Menu Aktif',
                            icon: Icons.inventory_2,
                            warnaIcon: Colors.purple,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: KartuInfo(
                            judul: 'Total Pesanan',
                            angka: '${stat.totalPesanan}',
                            satuan: 'Order',
                            keterangan: '${stat.keberhasilan} Keberhasilan',
                            icon: Icons.shopping_cart_outlined,
                            warnaIcon: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // status pesanan
                    StatusPesanan(statistik: stat),

                    SizedBox(height: 20),

                    // judul daftar makanan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pantauan Makanan &\nUrgency Discount',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textBlack,
                          ),
                        ),
                        Text(
                          '${stat.jumlahKantin} Kantin\nTerhubung',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    // daftar makanan
                    for (int i = 0; i < controller.listMakanan.length; i++)
                      ItemMakanan(
                        makanan: controller.listMakanan[i],
                        warnaDiskon: controller.warnaDiskon(
                          controller.listMakanan[i].diskon,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
