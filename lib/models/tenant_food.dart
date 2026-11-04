class TenantFood {
  const TenantFood({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
  });

  final int id;
  final String name;
  final int price;
  final int stock;

  TenantFood copyWith({String? name, int? price, int? stock}) {
    return TenantFood(
      id: id,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }
}
