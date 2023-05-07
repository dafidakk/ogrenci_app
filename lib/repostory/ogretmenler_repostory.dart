import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OgretmenRepository extends ChangeNotifier {
  final List<Ogretmen> ogretmenler = [
    Ogretmen('Faruk', 'Yılmaz', 45, 'Erkek'),
    Ogretmen('Semiha', 'Çelik', 38, 'Kadın')
  ];
}

final ogretmenlerProvider = ChangeNotifierProvider((ref) {
  return OgretmenRepository();
});

class Ogretmen {
  String ad;
  String soyad;
  int yas;
  String cinsiyet;

  Ogretmen(this.ad, this.soyad, this.yas, this.cinsiyet);
}
