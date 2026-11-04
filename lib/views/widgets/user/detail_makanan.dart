import 'package:flutter/material.dart';

import '/models/makanan_model.dart';
import '/utils/app_colors.dart';

class DetailMakanan extends StatelessWidget {
  final Makanan makanan;

  const DetailMakanan({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundApp,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fotoMakanan(context),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _informasiMakanan(),
                          const SizedBox(height: 22),
                          _informasiHarga(),
                          const SizedBox(height: 22),
                          _informasiStok(),
                          const SizedBox(height: 22),
                          _deskripsiMakanan(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _tombolPesan(context),
          ],
        ),
      ),
    );
  }

  // FOTO MAKANAN
  Widget _fotoMakanan(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 270,
          color: makanan.warnaBg,
          child: makanan.gambar != null
              ? Image.network(
                  makanan.gambar!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      makanan.icon,
                      size: 90,
                      color: AppColors.primaryDark,
                    );
                  },
                )
              : Icon(
                  makanan.icon,
                  size: 90,
                  color: AppColors.primaryDark,
                ),
        ),

        // TOMBOL KEMBALI
        Positioned(
          top: 15,
          left: 15,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.textBlack,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

        // LABEL DISKON
        Positioned(
          bottom: 15,
          left: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: AppColors.redUrgent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Diskon ${makanan.diskon}%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // INFORMASI MAKANAN
  Widget _informasiMakanan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          makanan.nama,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 18,
              color: AppColors.primary,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                makanan.kantin,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textGray,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _informasiHarga() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Harga Makanan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.textBlack,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Rp${makanan.hargaDiskon}',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Rp${makanan.hargaAsli}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textGray,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Hemat ${makanan.diskon}% dari harga asli',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _informasiStok() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greenSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            color: AppColors.primaryDark,
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ketersediaan Makanan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.textBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${makanan.stok} porsi tersedia',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _deskripsiMakanan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Deskripsi Makanan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Nikmati ${makanan.nama} dengan harga lebih hemat '
          'melalui ReFood. Makanan tersedia di ${makanan.kantin}. '
          'Segera pesan selama stok masih tersedia!',
          style: const TextStyle(
            fontSize: 13,
            height: 1.6,
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }

  Widget _tombolPesan(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: makanan.stok > 0
              ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Fitur pemesanan akan tersedia pada tahap berikutnya.',
                      ),
                    ),
                  );
                }
              : null,
          child: Text(
            makanan.stok > 0 ? 'Pesan Sekarang' : 'Stok Habis',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}