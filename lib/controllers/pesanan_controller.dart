import '../models/order_model.dart';

class PesananController {
  List<OrderModel> getPesananMasuk() {
    return [
      OrderModel(
        idPesanan: "#ORD-001",
        namaPembeli: "Andi Wijaya",
        namaMakanan: "Risol Mayo Ayam",
        harga: "Rp1.000",
        kodePickup: "RMA-01",
        lokasiKantin: "Warung Lestari Kantin TULT",
        rincianMenu: ["2pcs: Risol Ayam", "1pcs: Sosis Solo"],
        status: "Diproses",
      ),
      OrderModel(
        idPesanan: "#ORD-002",
        namaPembeli: "Budi Santoso",
        namaMakanan: "Nasi Ayam Serundeng",
        harga: "Rp8.000",
        kodePickup: "NAS-02",
        lokasiKantin: "Warung Lestari Kantin TULT",
        rincianMenu: ["1pcs: Nasi Ayam Serundeng"],
        status: "Siap Diambil",
      ),
    ];
  }

  void bukaScanner(String idPesanan) {
    print("Membuka kamera untuk scan barcode pesanan: $idPesanan");
  }
}