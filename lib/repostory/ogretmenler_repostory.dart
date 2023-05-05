class OgretmenRepository {
  final List<Ogretmen> ogretmenler = [
    Ogretmen('Faruk', 'Yılmaz', 45, 'Erkek'),
    Ogretmen('Semiha', 'Çelik', 38, 'Kadın')
  ];
}

class Ogretmen {
  String ad;
  String soyad;
  int yas;
  String cinsiyet;

  Ogretmen(this.ad, this.soyad, this.yas, this.cinsiyet);
}
