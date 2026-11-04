import 'package:flutter/material.dart';

import '../../controllers/tenant_catalog_controller.dart';
import '../../models/app_user.dart';
import '../../models/tenant_food.dart';
import '../../utils/app_colors.dart';
import 'food_form_page.dart';

class TenantCatalogPage extends StatefulWidget {
  const TenantCatalogPage({
    super.key,
    required this.user,
    required this.controller,
    required this.onLogout,
  });

  final AppUser user;
  final TenantCatalogController controller;
  final VoidCallback onLogout;

  @override
  State<TenantCatalogPage> createState() => _TenantCatalogPageState();
}

class _TenantCatalogPageState extends State<TenantCatalogPage> {
  int _selectedTab = 0;

  Future<void> _openFoodForm({TenantFood? food}) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => FoodFormPage(
          food: food,
          onSave: (name, price, stock) {
            if (food == null) {
              widget.controller.addFood(name: name, price: price, stock: stock);
            } else {
              widget.controller.updateFood(
                food.id,
                name: name,
                price: price,
                stock: stock,
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ReFood',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.user.location?.isNotEmpty == true
                              ? widget.user.location!
                              : 'Kenyang Hemat, Bumi Selamat',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Keluar',
                    onPressed: widget.onLogout,
                    icon: const Icon(Icons.logout, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Hasil Jualan Kamu Hari Ini',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    const Icon(
                      Icons.account_balance_wallet,
                      color: AppColors.primary,
                      size: 21,
                    ),
                    const SizedBox(width: 7),
                    Text('Rp ${widget.controller.totalSalesToday}'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: widget.controller,
                builder: (context, _) {
                  if (_selectedTab == 1) {
                    return const Center(
                      child: Text(
                        'Daftar pesanan kantin akan tampil di sini.',
                        style: TextStyle(color: AppColors.textGray),
                      ),
                    );
                  }
                  if (widget.controller.foods.isEmpty) {
                    return _EmptyCatalog(onAdd: () => _openFoodForm());
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
                    itemCount: widget.controller.foods.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Katalog Makanan',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => _openFoodForm(),
                              icon: const Icon(Icons.add),
                              label: const Text('Tambah'),
                            ),
                          ],
                        );
                      }
                      final food = widget.controller.foods[index - 1];
                      return _FoodTile(
                        food: food,
                        onTap: () => _openFoodForm(food: food),
                        onDelete: () => widget.controller.removeFood(food.id),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _TenantNavigationBar(
        selectedIndex: _selectedTab,
        onSelected: (index) => setState(() => _selectedTab = index),
        onAdd: () => _openFoodForm(),
      ),
    );
  }
}

class _EmptyCatalog extends StatelessWidget {
  const _EmptyCatalog({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              size: 84,
              color: Color(0xFF6DDB90),
            ),
            const SizedBox(height: 26),
            const Text(
              'Belum ada makanan yang\nkamu jual',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            const Text(
              'Yuk jual makanan sisa kamu',
              style: TextStyle(color: AppColors.textGray, fontSize: 15),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: onAdd,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 22),
              ),
              child: const Text('Tambah Makanan'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodTile extends StatelessWidget {
  const _FoodTile({
    required this.food,
    required this.onTap,
    required this.onDelete,
  });

  final TenantFood food;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F8F0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.fastfood, color: AppColors.primary),
        ),
        title: Text(
          food.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('Rp ${food.price}  •  Stok ${food.stock}'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') onDelete();
            if (value == 'edit') onTap();
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'delete', child: Text('Hapus')),
          ],
        ),
      ),
    );
  }
}

class _TenantNavigationBar extends StatelessWidget {
  const _TenantNavigationBar({
    required this.selectedIndex,
    required this.onSelected,
    required this.onAdd,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x18000000),
              blurRadius: 12,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _NavItem(
                icon: Icons.restaurant_menu,
                label: 'Makanan',
                selected: selectedIndex == 0,
                onTap: () => onSelected(0),
              ),
            ),
            Expanded(
              child: Center(
                child: IconButton.filled(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add, size: 30),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(58, 58),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _NavItem(
                icon: Icons.receipt_long_outlined,
                label: 'Pesanan',
                selected: selectedIndex == 1,
                onTap: () => onSelected(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primaryLight : AppColors.textGray;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(color: color, fontSize: 11)),
        ],
      ),
    );
  }
}
