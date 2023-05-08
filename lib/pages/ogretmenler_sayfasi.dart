import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/repostory/ogretmenler_repostory.dart';

import '../models/ogretmen.dart';

class OgretmenlerSayfasi extends ConsumerWidget {
  const OgretmenlerSayfasi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogretmenRepository = ref.watch(ogretmenlerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğretmenler'),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 32.0),
                    child: Text(
                        '${ogretmenRepository.ogretmenler.length} Öğretmen'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        ref.read(ogretmenlerProvider).download();
                      },
                      icon: const Icon(Icons.download)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => OgretmenSatiri(
                      ogretmenRepository.ogretmenler[index],
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: ogretmenRepository.ogretmenler.length),
          ),
        ],
      ),
    );
  }
}

class OgretmenSatiri extends StatelessWidget {
  final Ogretmen ogretmen;

  const OgretmenSatiri(
    this.ogretmen, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${ogretmen.ad} ${ogretmen.soyad}'),
      leading: IntrinsicWidth(
          child: Center(
              child: Text(ogretmen.cinsiyet == 'Kadın'
                  ? '🙎🏻‍♀️'
                  : '🙎🏻‍♂️'))), //🙎🏻‍♂️
    );
  }
}
