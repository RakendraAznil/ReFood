import '../models/pengguna_model.dart';
 
// Controller: mengatur data, pencarian, dan filter halaman pengguna
class PenggunaController {
  // filter yang sedang dipilih: 'Semua', 'Tenant', atau 'Konsumen'
  String filterDipilih = 'Semua';
 
  // kata yang diketik di kolom pencarian
  String kataCari = '';
 
  // jumlah total (masih dummy, nanti diambil dari database)
  int totalSemua = 375;
  int totalTenant = 25;
  int totalKonsumen = 350;
 
  // data pengguna (masih data dummy)
  List<Pengguna> semuaPengguna = [
    Pengguna(
      nama: 'Warung Lestari',
      email: 'kantin.tult@refood.ac.id',
      role: 'Tenant',
      aktif: true,
    ),
    Pengguna(
      nama: 'Andi Wijaya',
      email: 'andi.wijaya@student.ac.id',
      role: 'Konsumen',
      aktif: true,
    ),
    Pengguna(
      nama: 'Kantin Bu Sri',
      email: 'busri.kantin@refood.ac.id',
      role: 'Tenant',
      aktif: true,
    ),
    Pengguna(
      nama: 'Siti Rahma',
      email: 'siti.rahma@student.ac.id',
      role: 'Konsumen',
      aktif: true,
    ),
    Pengguna(
      nama: 'Budi Santoso',
      email: 'budi.s@student.ac.id',
      role: 'Konsumen',
      aktif: false,
    ),
  ];
 
  // ganti filter (Semua / Tenant / Konsumen)
  void gantiFilter(String filter) {
    filterDipilih = filter;
  }
 
  // simpan kata pencarian
  void cariPengguna(String kata) {
    kataCari = kata;
  }
 
  // ambil data yang sudah difilter dan dicari
  List<Pengguna> getPenggunaTampil() {
    List<Pengguna> hasil = [];
 
    for (int i = 0; i < semuaPengguna.length; i++) {
      Pengguna p = semuaPengguna[i];
 
      // cek filter
      bool cocokFilter = filterDipilih == 'Semua' || p.role == filterDipilih;
 
      // cek pencarian (huruf besar/kecil diabaikan)
      String kata = kataCari.toLowerCase();
      bool cocokCari = p.nama.toLowerCase().contains(kata) ||
          p.email.toLowerCase().contains(kata) ||
          p.role.toLowerCase().contains(kata);
 
      if (cocokFilter && cocokCari) {
        hasil.add(p);
      }
    }
 
    return hasil;
  }
}