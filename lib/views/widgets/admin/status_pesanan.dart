import 'package:flutter/material.dart';

import '../../../models/statistik_model.dart';
import '../../../utils/app_colors.dart';

class StatusPesanan extends StatelessWidget {
  final Statistik statistik;

  StatusPesanan({required this.statistik});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.coolGray),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status Pesanan Real-time',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              Text(
                'Hari Ini',
                style: TextStyle(fontSize: 12, color: AppColors.textGray),
              ),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: kotakStatus(
                  '${statistik.menunggu}',
                  'Menunggu',
                  AppColors.orangeWarning,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: kotakStatus(
                  '${statistik.diproses}',
                  'Diproses',
                  Colors.blue,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: kotakStatus(
                  '${statistik.selesai}',
                  'Selesai',
                  AppColors.primary,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: kotakStatus(
                  '${statistik.batal}',
                  'Batal',
                  AppColors.redUrgent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // kotak kecil untuk satu status
  Widget kotakStatus(String angka, String label, Color warna) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundApp,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            angka,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: warna,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: AppColors.textGray),
          ),
        ],
      ),
    );
  }
}
