import '../models/ticket_model.dart';

class TicketController {
  TicketModel getTicketData() {
    return TicketModel(
      idPesanan: "#ORD-001",
      namaPembeli: "Andi Wijaya",
      lokasiKantin: "Warung Lestari Kantin TULT",
      totalHarga: "Rp1000",
      daftarMenu: ["2pcs: Risol Ayam", "1pcs: Sosis Solo"],
      kodePickup: "RMA-01",
      status: "Menunggu Diambil",
    );
  }

  void verifikasiTiket(String idPesanan) {
    print("Tiket $idPesanan berhasil diverifikasi! Makanan sudah diserahkan.");
  }
}