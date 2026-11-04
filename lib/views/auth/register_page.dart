import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../models/app_user.dart';
import '../../utils/app_colors.dart';
import 'auth_components.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.controller,
    required this.onRegistered,
  });

  final AuthController controller;
  final ValueChanged<AppUser> onRegistered;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  UserRole _role = UserRole.tenant;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final user = widget.controller.register(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      role: _role,
      location: _role == UserRole.tenant ? _locationController.text : null,
    );
    widget.onRegistered(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthBrand(compact: true),
                const SizedBox(height: 22),
                const Text(
                  'Buat akun ReFood',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                AuthRoleSelector(
                  role: _role,
                  onChanged: (role) => setState(() => _role = role),
                ),
                const SizedBox(height: 16),
                AuthField(
                  controller: _nameController,
                  label: 'Nama',
                  hint: 'masukan nama anda',
                  textInputAction: TextInputAction.next,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Nama wajib diisi'
                      : null,
                ),
                const SizedBox(height: 13),
                AuthField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'masukan email anda',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email wajib diisi';
                    }
                    if (!value.contains('@'))
                      return 'Masukkan email yang valid';
                    return null;
                  },
                ),
                if (_role == UserRole.tenant) ...[
                  const SizedBox(height: 13),
                  AuthField(
                    controller: _locationController,
                    label: 'Lokasi',
                    hint: 'masukan lokasi kantin',
                    textInputAction: TextInputAction.next,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Lokasi kantin wajib diisi'
                        : null,
                  ),
                ],
                const SizedBox(height: 13),
                AuthField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'masukan password anda',
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) => value == null || value.length < 6
                      ? 'Password minimal 6 karakter'
                      : null,
                ),
                const SizedBox(height: 13),
                AuthField(
                  controller: _confirmationController,
                  label: 'Konfirmasi Password',
                  hint: 'masukan ulang password anda',
                  obscureText: true,
                  validator: (value) => value != _passwordController.text
                      ? 'Konfirmasi password belum sama'
                      : null,
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: _submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryLight,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Daftar'),
                  ),
                ),
                const SizedBox(height: 19),
                const AuthDivider(),
                const SizedBox(height: 18),
                GoogleAuthButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pendaftaran Google belum dihubungkan.'),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(color: AppColors.textGray),
                        children: [
                          TextSpan(text: 'Sudah memiliki akun? '),
                          TextSpan(
                            text: 'Masuk',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
