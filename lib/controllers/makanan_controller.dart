import 'package:flutter/material.dart';

import '../models/makanan_model.dart';

class MakananController extends ChangeNotifier {
  final List<Makanan> _daftarMakanan = [
    Makanan(
      nama: 'Nasi Ayam Serundeng',
      kantin: 'Kantin Lestari Asrama Putra',
      diskon: 50,
      stok: 5,
      hargaDiskon: '8000',
      hargaAsli: '16000',
      icon: Icons.rice_bowl,
      warnaBg: const Color(0xFFFFE0B2),
      gambar:
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=600',
    ),
    Makanan(
      nama: 'Risol Mayo Ayam',
      kantin: 'Tempat Asrama Cewek',
      diskon: 60,
      stok: 8,
      hargaDiskon: '1000',
      hargaAsli: '2500',
      icon: Icons.fastfood,
      warnaBg: const Color(0xFFFFE0B2),
      gambar:
          'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=600',
    ),
    Makanan(
      nama: 'Nasi Goreng Spesial',
      kantin: 'Kantin Lestari Asrama Putra',
      diskon: 40,
      stok: 4,
      hargaDiskon: '10000',
      hargaAsli: '17000',
      icon: Icons.rice_bowl,
      warnaBg: const Color(0xFFFFE0B2),
      gambar:
          'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=600',
    ),
    Makanan(
      nama: 'Ayam Crispy',
      kantin: 'Tempat Asrama Cewek',
      diskon: 50,
      stok: 6,
      hargaDiskon: '9000',
      hargaAsli: '18000',
      icon: Icons.fastfood,
      warnaBg: const Color(0xFFFFE0B2),
      gambar:
          'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=600',
    ),
  ];

  List<Makanan> _makananDitampilkan = [];

  MakananController() {
    _makananDitampilkan = List.from(_daftarMakanan);
  }

  List<Makanan> get daftarMakanan => _makananDitampilkan;

  void cariMakanan(String keyword) {
    if (keyword.trim().isEmpty) {
      _makananDitampilkan = List.from(_daftarMakanan);
    } else {
      _makananDitampilkan = _daftarMakanan.where((makanan) {
        return makanan.nama.toLowerCase().contains(keyword.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }
}
