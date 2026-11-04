import 'package:flutter/material.dart';

import '../../models/makanan_model.dart';
import '../../utils/app_colors.dart';

class ItemMakanan extends StatelessWidget {
  final Makanan makanan;
  final Color warnaDiskon;

  ItemMakanan({required this.makanan, required this.warnaDiskon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.coolGray),
      ),
      child: Row(
        children: [
          // icon makanan
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: makanan.warnaBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(makanan.icon, color: Colors.brown),
          ),
          SizedBox(width: 12),

          // nama, kantin, diskon, stok
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  makanan.nama,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  makanan.kantin,
                  style: TextStyle(fontSize: 12, color: AppColors.textGray),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: warnaDiskon.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Diskon ${makanan.diskon}%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: warnaDiskon,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Stok: ',
                      style: TextStyle(fontSize: 11, color: AppColors.textGray),
                    ),
                    Text(
                      '${makanan.stok}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // harga
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                makanan.hargaDiskon,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                makanan.hargaAsli,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textGray,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
