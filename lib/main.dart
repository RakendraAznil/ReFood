import 'package:flutter/material.dart';

import 'controllers/auth_controller.dart';
import 'controllers/tenant_catalog_controller.dart';
import 'models/app_user.dart';
import 'views/auth/login_page.dart';
import 'views/auth/register_page.dart';
import 'views/tenant/tenant_catalog_page.dart';
import 'views/widgets/user/home_page_user.dart';

void main() {
  runApp(const ReFoodApp());
}

class ReFoodApp extends StatefulWidget {
  const ReFoodApp({super.key});

  @override
  State<ReFoodApp> createState() => _ReFoodAppState();
}

class _ReFoodAppState extends State<ReFoodApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final AuthController _authController = AuthController();
  final TenantCatalogController _catalogController = TenantCatalogController();

  @override
  void dispose() {
    _authController.dispose();
    _catalogController.dispose();
    super.dispose();
  }

  void _openHome(AppUser user) {
    final Widget page = user.role == UserRole.tenant
        ? TenantCatalogPage(
            user: user,
            controller: _catalogController,
            onLogout: _logout,
          )
        : const HomePageUser();

    _navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => page),
      (route) => false,
    );
  }

  void _logout() {
    _authController.logout();
    _navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => LoginPage(
          controller: _authController,
          onAuthenticated: _openHome,
          onOpenRegister: _openRegister,
        ),
      ),
      (route) => false,
    );
  }

  void _openRegister() {
    _navigatorKey.currentState?.push<void>(
      MaterialPageRoute<void>(
        builder: (_) =>
            RegisterPage(controller: _authController, onRegistered: _openHome),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'ReFood',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF27AE60)),
        fontFamily: 'Roboto',
      ),
      home: LoginPage(
        controller: _authController,
        onAuthenticated: _openHome,
        onOpenRegister: _openRegister,
      ),
    );
  }
}
