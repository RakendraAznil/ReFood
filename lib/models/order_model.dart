class OrderModel {
  String idPesanan;
  String namaPembeli;
  String namaMakanan;
  String harga;
  String kodePickup;
  String lokasiKantin;
  List<String> rincianMenu;
  String status;

  OrderModel({
    required this.idPesanan,
    required this.namaPembeli,
    required this.namaMakanan,
    required this.harga,
    required this.kodePickup,
    required this.lokasiKantin,
    required this.rincianMenu,
    this.status = "Diproses",
  });
}