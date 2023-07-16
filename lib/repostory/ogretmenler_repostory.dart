import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/services/data_services.dart';

import '../models/ogretmen.dart';

class OgretmenRepository extends ChangeNotifier {
  List<Ogretmen> ogretmenler = [
    Ogretmen('Faruk', 'Yılmaz', 45, 'Erkek'),
    Ogretmen('Semiha', 'Çelik', 38, 'Kadın')
  ];

  final DataServices dataService;
  OgretmenRepository(this.dataService);

  Future<void> indir() async {
    Ogretmen ogretmen = await dataService.ogretmenIndir();

    ogretmenler.add(ogretmen);
    notifyListeners();
  }

  Future<List<Ogretmen>> hepsiniGetir() async {
    ogretmenler = await dataService.ogretmenleriGetir();
    return ogretmenler;
  }
}

final ogretmenlerProvider = ChangeNotifierProvider((ref) {
  return OgretmenRepository(ref.watch(dataServiceProvider));
});

final ogretmenlerListesiProvider = FutureProvider((ref) {
  return ref.watch(ogretmenlerProvider).hepsiniGetir();
});
