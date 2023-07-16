import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/repostory/ogretmenler_repostory.dart';

import '../models/ogretmen.dart';
import 'ogretmen/ogretmen_form.dart';

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
                const Align(
                  alignment: Alignment.centerRight,
                  child: OgretmenIndirmeButonu(),
                ),
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: () async {
              ref.refresh(ogretmenlerListesiProvider);
            },
            child: ref.watch(ogretmenlerListesiProvider).when(
                  data: (List<Ogretmen> data) => ListView.separated(
                      itemBuilder: (context, index) => OgretmenSatiri(
                            data[index],
                          ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data.length),
                  error: (error, stackTrace) {
                    return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Text('error'));
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created =
              await Navigator.of(context).push<bool>(MaterialPageRoute(
            builder: (context) {
              return const OgretmenForm();
            },
          ));

          if (created == true) {
            if (kDebugMode) {
              print('Sayfayı yenile');
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class OgretmenIndirmeButonu extends StatefulWidget {
  const OgretmenIndirmeButonu({
    Key? key,
  }) : super(key: key);

  @override
  State<OgretmenIndirmeButonu> createState() => _OgretmenIndirmeButonuState();
}

class _OgretmenIndirmeButonuState extends State<OgretmenIndirmeButonu> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return isLoading
          ? const CircularProgressIndicator()
          : IconButton(
              onPressed: () async {
                try {
                  setState(() {
                    isLoading = true;
                  });

                  // TODO loading
                  // TODO error
                  await ref.read(ogretmenlerProvider).indir();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('İçerik indirildi ve kaydedildi')));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              icon: const Icon(Icons.download));
    });
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
