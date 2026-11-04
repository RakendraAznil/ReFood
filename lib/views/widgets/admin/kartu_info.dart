import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class KartuInfo extends StatelessWidget {
  final String judul;
  final String angka;
  final String satuan;
  final String keterangan;
  final IconData icon;
  final Color warnaIcon;

  KartuInfo({
    required this.judul,
    required this.angka,
    required this.satuan,
    required this.keterangan,
    required this.icon,
    required this.warnaIcon,
  });

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                judul,
                style: TextStyle(fontSize: 12, color: AppColors.textGray),
              ),
              Icon(icon, color: warnaIcon, size: 20),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                angka,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(width: 6),
              Text(
                satuan,
                style: TextStyle(fontSize: 14, color: AppColors.textGray),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            keterangan,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
