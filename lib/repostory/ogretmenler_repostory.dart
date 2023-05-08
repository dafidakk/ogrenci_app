import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ogretmen.dart';

class OgretmenRepository extends ChangeNotifier {
  final List<Ogretmen> ogretmenler = [
    Ogretmen('Faruk', 'Yılmaz', 45, 'Erkek'),
    Ogretmen('Semiha', 'Çelik', 38, 'Kadın')
  ];

  void download() {
    const j = """ {
      "ad": "Yeni",
      "soyad": "Yenioğlu",
      "yas": 22,
      "cinsiyet": "Erkek"
    }""";

    final m = jsonDecode(j);

    final Ogretmen ogretmen = Ogretmen.fromMap(m);
    ogretmenler.add(ogretmen);
    notifyListeners();
  }
}

final ogretmenlerProvider = ChangeNotifierProvider((ref) {
  return OgretmenRepository();
});
