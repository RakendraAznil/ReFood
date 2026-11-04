class TicketModel {
  String idPesanan;
  String namaPembeli;
  String lokasiKantin;
  String totalHarga;
  List<String> daftarMenu;
  String kodePickup;
  String status; 

  TicketModel({
    required this.idPesanan,
    required this.namaPembeli,
    required this.lokasiKantin,
    required this.totalHarga,
    required this.daftarMenu,
    required this.kodePickup,
    required this.status,
  });
}