import 'package:flutter/material.dart';

import '../models/makanan_model.dart';
import '../models/statistik_model.dart';
import '../utils/app_colors.dart';

// Controller: tempat mengatur data untuk halaman dashboard
class DashboardController {
  // data angka dashboard (masih data dummy)
  Statistik statistik = Statistik(
    stokMakanan: 156,
    menuAktif: 28,
    totalPesanan: 420,
    keberhasilan: '94.5%',
    menunggu: 12,
    diproses: 18,
    selesai: 385,
    batal: 5,
    jumlahKantin: 4,
  );

  // data makanan (masih data dummy)
  List<Makanan> listMakanan = [
    Makanan(
      nama: 'Risol Mayo Ayam',
      kantin: 'Warung Lestari Kantin TULT',
      diskon: 50,
      stok: 5,
      hargaDiskon: 'Rp 1.000',
      hargaAsli: 'Rp 2.000',
      icon: Icons.fastfood,
      warnaBg: AppColors.greenSurface,
    ),
    Makanan(
      nama: 'Nasi Ayam Serundeng',
      kantin: 'Kantin Asrama Putra',
      diskon: 30,
      stok: 12,
      hargaDiskon: 'Rp 8.000',
      hargaAsli: 'Rp 12.000',
      icon: Icons.rice_bowl,
      warnaBg: Color(0xFFFFF8E1),
    ),
    Makanan(
      nama: 'Kopi Susu Gula Aren',
      kantin: 'Kedai Kopi Kampus',
      diskon: 20,
      stok: 8,
      hargaDiskon: 'Rp 10.000',
      hargaAsli: 'Rp 13.000',
      icon: Icons.coffee,
      warnaBg: Color(0xFFE8EEFF),
    ),
  ];

  // menentukan warna diskon berdasarkan besar diskon
  Color warnaDiskon(int diskon) {
    if (diskon >= 50) {
      return AppColors.redUrgent;
    } else if (diskon >= 30) {
      return AppColors.orangeWarning;
    } else {
      return AppColors.primary;
    }
  }
}
