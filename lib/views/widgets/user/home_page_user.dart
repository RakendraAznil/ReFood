import 'package:flutter/material.dart';

import '/controllers/makanan_controller.dart';
import 'detail_makanan.dart';
import '/models/makanan_model.dart';
import '/utils/app_colors.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final MakananController controller = MakananController();
  final TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundApp,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 20),
                    _saldoCard(),
                    const SizedBox(height: 18),
                    _searchBar(),
                    const SizedBox(height: 20),
                    const Text(
                      'Makanan Diskon Hari Ini',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _daftarMakanan(),
                  ],
                ),
              ),
            ),
            _bottomNavigation(),
          ],
        ),
      ),
    );
  }

  // HEADER REFOOD
  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'ReFood',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Kenyang Hemat Bumi Selamat',
                style: TextStyle(fontSize: 12, color: AppColors.textBlack),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.greenSurface,
          child: Icon(Icons.person, color: AppColors.primaryDark, size: 25),
        ),
      ],
    );
  }

  // KARTU SALDO
  Widget _saldoCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Saldo Kamu Saat Ini',
              style: TextStyle(fontSize: 13, color: AppColors.textBlack),
            ),
          ),
          const Icon(
            Icons.account_balance_wallet,
            color: AppColors.primary,
            size: 22,
          ),
          const SizedBox(width: 7),
          const Text(
            'Rp100.000',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppColors.textBlack,
            ),
          ),
        ],
      ),
    );
  }

  // KOLOM PENCARIAN
  Widget _searchBar() {
    return TextField(
      controller: searchController,
      onChanged: controller.cariMakanan,
      decoration: InputDecoration(
        hintText: 'Nasi Ayam, Sari Roti, Wafer........',
        hintStyle: const TextStyle(color: AppColors.softGray, fontSize: 12),
        prefixIcon: const Icon(Icons.search, color: AppColors.softGray),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.softGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.softGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  // GRID MAKANAN
  Widget _daftarMakanan() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final List<Makanan> makanan = controller.daftarMakanan;

        if (makanan.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(30),
            child: Center(
              child: Text(
                'Makanan tidak ditemukan',
                style: TextStyle(color: AppColors.textGray),
              ),
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: makanan.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, index) {
            return _foodCard(makanan[index]);
          },
        );
      },
    );
  }

  // CARD MAKANAN
  Widget _foodCard(Makanan makanan) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMakanan(makanan: makanan),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                color: makanan.warnaBg,
                child: makanan.gambar != null
                    ? Image.network(
                        makanan.gambar!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            makanan.icon,
                            size: 55,
                            color: AppColors.primaryDark,
                          );
                        },
                      )
                    : Icon(
                        makanan.icon,
                        size: 55,
                        color: AppColors.primaryDark,
                      ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(9, 8, 7, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      makanan.nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp${makanan.hargaDiskon}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: AppColors.textGray,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            makanan.kantin,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 8,
                              color: AppColors.textGray,
                            ),
                          ),
                        ),
                      ],
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

  // BOTTOM NAVIGATION
  Widget _bottomNavigation() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.restaurant, 'Makanan', 0),
          _navItem(Icons.receipt_long, 'Pesanan', 1),
          _navItem(Icons.account_circle_outlined, 'Profile', 2),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool active = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        if (index != 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Halaman $label belum tersedia'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: active ? AppColors.primary : AppColors.textGray,
              size: 23,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: active ? AppColors.primary : AppColors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
