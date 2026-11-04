import '../models/user_model.dart';

class ProfileController {
  UserModel getUserData() {
    return UserModel(
      nama: "Andi Wijaya",
      email: "andiwj@gmail.com",
      saldo: "Rp100.000",
    );
  }

  void logout() {
    print("Pengguna berhasil keluar");
  }
}