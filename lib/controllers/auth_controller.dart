import 'package:flutter/foundation.dart';

import '../models/app_user.dart';

class AuthController extends ChangeNotifier {
  AppUser? currentUser;

  AppUser signIn({
    required String email,
    required String password,
    required UserRole role,
  }) {
    final normalizedEmail = email.trim();
    currentUser = AppUser(
      name: normalizedEmail.split('@').first,
      email: normalizedEmail,
      role: role,
    );
    notifyListeners();
    return currentUser!;
  }

  AppUser register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
    String? location,
  }) {
    currentUser = AppUser(
      name: name.trim(),
      email: email.trim(),
      role: role,
      location: location?.trim(),
    );
    notifyListeners();
    return currentUser!;
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }
}
