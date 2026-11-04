import 'package:flutter/material.dart';

class Makanan {
  String nama;
  String kantin;
  int diskon;
  int stok;
  String hargaDiskon;
  String hargaAsli;
  IconData icon;
  Color warnaBg;
  String? gambar;

  Makanan({
    required this.nama,
    required this.kantin,
    required this.diskon,
    required this.stok,
    required this.hargaDiskon,
    required this.hargaAsli,
    required this.icon,
    required this.warnaBg,
    this.gambar,
  });
}
