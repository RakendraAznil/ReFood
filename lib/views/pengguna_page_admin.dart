import 'package:flutter/material.dart';

import '../controllers/pengguna_controller_admin.dart';
import '../models/pengguna_model.dart';
import '../utils/app_colors.dart';
import 'widgets/admin/header_pengguna.dart';
import 'widgets/admin/item_pengguna.dart';

class PenggunaPage extends StatefulWidget {
  @override
  _PenggunaPageState createState() => _PenggunaPageState();
}

class _PenggunaPageState extends State<PenggunaPage> {
  // panggil controller
  PenggunaController controller = PenggunaController();

  @override
  Widget build(BuildContext context) {
    // ambil data yang sudah difilter & dicari
    List<Pengguna> dataTampil = controller.getPenggunaTampil();

    return Scaffold(
      backgroundColor: AppColors.backgroundApp,
      body: SafeArea(
        child: Column(
          children: [
            // header
            HeaderPengguna(total: controller.totalSemua),

            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  // kolom pencarian
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        controller.cariPengguna(value);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari nama, email, atau tenant...',
                      hintStyle: TextStyle(
                        color: AppColors.textGray,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(Icons.search, color: AppColors.textGray),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.softGray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),

                  SizedBox(height: 12),

                  // tombol filter
                  Row(
                    children: [
                      buatChip('Semua (${controller.totalSemua})', 'Semua'),
                      SizedBox(width: 8),
                      buatChip('Tenant (${controller.totalTenant})', 'Tenant'),
                      SizedBox(width: 8),
                      buatChip(
                        'Konsumen (${controller.totalKonsumen})',
                        'Konsumen',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 12),

            // daftar pengguna
            Expanded(
              child: dataTampil.isEmpty
                  ? Center(
                      child: Text(
                        'Data tidak ditemukan',
                        style: TextStyle(color: AppColors.textGray),
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      children: [
                        for (int i = 0; i < dataTampil.length; i++)
                          ItemPengguna(pengguna: dataTampil[i]),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // tombol filter kecil (Semua / Tenant / Konsumen)
  Widget buatChip(String label, String nilaiFilter) {
    bool dipilih = controller.filterDipilih == nilaiFilter;

    return GestureDetector(
      onTap: () {
        setState(() {
          controller.gantiFilter(nilaiFilter);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: dipilih ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: dipilih ? AppColors.primary : AppColors.softGray,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: dipilih ? FontWeight.bold : FontWeight.normal,
            color: dipilih ? Colors.white : AppColors.textBlack,
          ),
        ),
      ),
    );
  }
}
