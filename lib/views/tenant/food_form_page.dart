import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/tenant_food.dart';
import '../../utils/app_colors.dart';

typedef FoodSaveCallback = void Function(String name, int price, int stock);

class FoodFormPage extends StatefulWidget {
  const FoodFormPage({super.key, required this.onSave, this.food});

  final TenantFood? food;
  final FoodSaveCallback onSave;

  @override
  State<FoodFormPage> createState() => _FoodFormPageState();
}

class _FoodFormPageState extends State<FoodFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;

  bool get _isEditing => widget.food != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.food?.name ?? '');
    _priceController = TextEditingController(
      text: widget.food == null ? '' : widget.food!.price.toString(),
    );
    _stockController = TextEditingController(
      text: widget.food == null ? '' : widget.food!.stock.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSave(
      _nameController.text.trim(),
      int.parse(_priceController.text),
      int.parse(_stockController.text),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          _isEditing ? 'Edit Makanan' : 'Form Makanan',
          style: const TextStyle(
            color: AppColors.primaryLight,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 4, 22, 28),
            children: [
              const Text(
                'Foto Makanan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fitur pilih foto belum dihubungkan.'),
                  ),
                ),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  height: 152,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFD8DDE0),
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 42,
                        color: Color(0xFFAAAAAA),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Upload foto makanan',
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'JPG, JPEG, PNG kurang dari 1MB',
                        style: TextStyle(color: Color(0xFFAAAAAA)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 17),
              _FormField(
                controller: _nameController,
                label: 'Nama Makanan',
                hint: 'cth: risol mayo....',
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Nama makanan wajib diisi'
                    : null,
              ),
              const SizedBox(height: 14),
              _FormField(
                controller: _priceController,
                label: 'Harga (Rp)',
                hint: 'cth: Rp1000',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final price = int.tryParse(value ?? '');
                  return price == null || price <= 0
                      ? 'Masukkan harga lebih dari 0'
                      : null;
                },
              ),
              const SizedBox(height: 14),
              _FormField(
                controller: _stockController,
                label: 'Stok',
                hint: 'cth: 1',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final stock = int.tryParse(value ?? '');
                  return stock == null || stock <= 0
                      ? 'Masukkan stok minimal 1'
                      : null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: FilledButton(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: Text(_isEditing ? 'Simpan Perubahan' : 'Post Makanan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFB7BEC4), fontSize: 12),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Color(0xFFC4CCD1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Color(0xFFC4CCD1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
