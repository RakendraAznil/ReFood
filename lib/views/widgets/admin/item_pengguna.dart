import 'package:flutter/material.dart';

import '../../../models/pengguna_model.dart';
import '../../../utils/app_colors.dart';
 
class ItemPengguna extends StatelessWidget {
  final Pengguna pengguna;

  ItemPengguna({required this.pengguna});

  @override
  Widget build(BuildContext context) {
    // tentukan icon & warna sesuai role dan status
    IconData icon;
    Color warnaIcon;
    Color warnaAvatar;
    Color warnaBadge;

    if (pengguna.aktif == false) {
      // pengguna nonaktif tampil abu-abu
      icon = Icons.person;
      warnaIcon = Colors.deepPurple;
      warnaAvatar = AppColors.coolGray;
      warnaBadge = AppColors.textGray;
    } else if (pengguna.role == 'Tenant') {
      icon = Icons.store;
      warnaIcon = AppColors.accent;
      warnaAvatar = AppColors.orangeWarning.withOpacity(0.2);
      warnaBadge = AppColors.orangeWarning;
    } else {
      icon = Icons.school;
      warnaIcon = AppColors.textBlack;
      warnaAvatar = AppColors.greenSurface;
      warnaBadge = AppColors.primary;
    }

    // warna status Aktif / Nonaktif
    Color warnaStatus = pengguna.aktif
        ? AppColors.primary
        : AppColors.redUrgent;
    Color warnaBgStatus = pengguna.aktif
        ? AppColors.greenSurface
        : AppColors.redUrgent.withOpacity(0.12);

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
          // avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: warnaAvatar,
            child: Icon(icon, color: warnaIcon, size: 22),
          ),
          SizedBox(width: 12),

          // nama, badge role, email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        pengguna.nama,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: warnaBadge.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: warnaBadge),
                      ),
                      child: Text(
                        pengguna.role,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: warnaBadge,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  pengguna.email,
                  style: TextStyle(fontSize: 12, color: AppColors.textGray),
                ),
              ],
            ),
          ),

          // status aktif / nonaktif
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: warnaBgStatus,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              pengguna.aktif ? 'Aktif' : 'Nonaktif',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: warnaStatus,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
