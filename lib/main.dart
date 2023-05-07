import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/repostory/mesajlar_repostory.dart';
import 'package:ogrenci_app/repostory/ogretmenler_repostory.dart';
import 'pages/ogrenciler_sayfasi.dart';
import 'pages/mesajlar_sayfasi.dart';
import 'pages/ogretmenler_sayfasi.dart';
import 'repostory/ogrenciler_repostory.dart';

void main() {
  runApp(const ProviderScope(child: OgrenciApp()));
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

class AnaSayfa extends ConsumerWidget {
  const AnaSayfa({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogrencilerRepository = ref.watch(ogrencilerProvider);
     final ogretmenRepository = ref.watch(ogretmenlerProvider);
      final mesajlarRepository = ref.watch(mesajlarProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                _mesajlaraGit(context);
              },
              child: Text('${ref.watch(yeniMesajSayisiProvider)} Yeni Mesaj'),
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
      return const OgretmenlerSayfasi();
    }));
  }

  Future<void> _mesajlaraGit(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const MesajlarSayfasi();
    }));
    
  }

  void _ogrencilereGit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const OgrencilerSayfasi();
    }));
  }
}
