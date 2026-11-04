import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../models/app_user.dart';
import '../../utils/app_colors.dart';
import 'auth_components.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.controller,
    required this.onAuthenticated,
    required this.onOpenRegister,
  });

  final AuthController controller;
  final ValueChanged<AppUser> onAuthenticated;
  final VoidCallback onOpenRegister;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _role = UserRole.tenant;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final user = widget.controller.signIn(
      email: _emailController.text,
      password: _passwordController.text,
      role: _role,
    );
    widget.onAuthenticated(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 80,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ReFoodMark(size: 64),
                    const SizedBox(height: 18),
                    const Text(
                      'Halo, Selamat Datang di',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'ReFood',
                      style: TextStyle(
                        fontSize: 28,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Masuk sebagai',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    AuthRoleSelector(
                      role: _role,
                      onChanged: (role) => setState(() => _role = role),
                    ),
                    const SizedBox(height: 22),
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
                    const SizedBox(height: 12),
                    AuthField(
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'masukan password anda',
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator: (value) => value == null || value.length < 6
                          ? 'Password minimal 6 karakter'
                          : null,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primaryLight,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Masuk'),
                      ),
                    ),
                    const SizedBox(height: 26),
                    const AuthDivider(),
                    const SizedBox(height: 22),
                    GoogleAuthButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(
                            const SnackBar(
                              content: Text('Login Google belum dihubungkan.'),
                            ),
                          ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            'Belum punya akun? ',
                            style: TextStyle(color: AppColors.textGray),
                          ),
                          GestureDetector(
                            onTap: widget.onOpenRegister,
                            child: const Text(
                              'Daftar',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
