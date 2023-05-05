import 'package:flutter/material.dart';
import 'pages/ogrenciler_sayfasi.dart';
import 'pages/mesajlar_sayfasi.dart';
import 'pages/ogretmenler_sayfasi.dart';
import 'repostory/ogrenciler_repostory.dart';
import 'repostory/mesajlar_repostory.dart';
import 'repostory/ogretmenler_repostory.dart';

void main() {
  runApp(const OgrenciApp());
}

class OgrenciApp extends StatelessWidget {
  const OgrenciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Öğrenci Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnaSayfa(title: 'Öğrenci Ana Sayfa'),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key, required this.title});

  final String title;

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  MesajlarRepository mesajlarRepository = MesajlarRepository();
  OgrenciRepository ogrencilerRepository = OgrenciRepository();
  OgretmenRepository ogretmenRepository = OgretmenRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                _mesajlaraGit(context);
              },
              child: Text('${mesajlarRepository.yeniMesajSayisi} Yeni Mesaj'),
            ),
            TextButton(
              onPressed: () {
                _ogrencilereGit(context);
              },
              child: Text('${ogrencilerRepository.ogrenciler.length} Öğrenci'),
            ),
            TextButton(
              onPressed: () {
                _ogretmenlereGit(context);
              },
              child: Text('${ogretmenRepository.ogretmenler.length} Öğretmen'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Ogrenci Adı'),
            ),
            ListTile(
              title: const Text('Öğrenciler'),
              onTap: () {
                _ogrencilereGit(context);
              },
            ),
            ListTile(
              title: const Text('Öğretmenler'),
              onTap: () {
                _ogretmenlereGit(context);
              },
            ),
            ListTile(
              title: const Text('Mesajlar'),
              onTap: () {
                _mesajlaraGit(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _ogretmenlereGit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OgretmenlerSayfasi(ogretmenRepository);
    }));
  }

  Future<void> _mesajlaraGit(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MesajlarSayfasi(mesajlarRepository);
    }));
    setState(() {});
  }

  void _ogrencilereGit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OgrencilerSayfasi(ogrencilerRepository);
    }));
  }
}
