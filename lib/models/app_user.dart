enum UserRole { tenant, buyer }

extension UserRoleLabel on UserRole {
  String get label => this == UserRole.tenant ? 'Kantin' : 'Pembeli';
}

class AppUser {
  const AppUser({
    required this.name,
    required this.email,
    required this.role,
    this.location,
  });

  final String name;
  final String email;
  final UserRole role;
  final String? location;
}
