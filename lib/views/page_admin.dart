import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'dashboard_page_admin.dart';
import 'pengguna_page_admin.dart';

// Halaman utama yang isinya menu bawah + pindah-pindah halaman
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // index menu bawah yang sedang dipilih
  int selectedIndex = 0;

  // daftar halaman sesuai urutan menu
  List<Widget> halaman = [DashboardPage(), PenggunaPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: halaman),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textGray,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          // kalau tekan "Keluar" munculkan dialog
          if (index == 2) {
            tampilkanDialogKeluar();
          } else {
            setState(() {
              selectedIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Memantau',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pengguna',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: AppColors.redUrgent),
            label: 'Keluar',
          ),
        ],
      ),
    );
  }

  // dialog saat tekan tombol keluar
  void tampilkanDialogKeluar() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Keluar'),
          content: Text('Apakah kamu yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // nanti bisa diarahkan ke halaman login
              },
              child: Text('Ya', style: TextStyle(color: AppColors.redUrgent)),
            ),
          ],
        );
      },
    );
  }
}
