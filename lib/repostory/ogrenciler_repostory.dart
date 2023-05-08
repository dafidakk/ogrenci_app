import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ogrenci.dart';

class OgrenciRepository extends ChangeNotifier {
  final List<Ogrenci> ogrenciler = [
    Ogrenci('Ali', 'Yılmaz', 18, 'Erkek'),
    Ogrenci('Ayşe', '', 20, 'Kadın')
  ];

  final Set<Ogrenci> sevdiklerim = {};

  void sev(Ogrenci ogrenci, bool seviyorMuyum) {
    if (seviyorMuyum) {
      sevdiklerim.add(ogrenci);
    } else {
      sevdiklerim.remove(ogrenci);
    }
    notifyListeners();
  }

  bool seviyorMuyum(Ogrenci ogrenci) {
    return sevdiklerim.contains(ogrenci);
  }
}

final ogrencilerProvider = ChangeNotifierProvider((ref) {
  return OgrenciRepository();
});


