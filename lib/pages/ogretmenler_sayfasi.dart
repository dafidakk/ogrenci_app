import 'package:flutter/material.dart';
import 'package:ogrenci_app/repostory/ogretmenler_repostory.dart';

class OgretmenlerSayfasi extends StatefulWidget {
  final OgretmenRepository ogretmenRepository;
  const OgretmenlerSayfasi(this.ogretmenRepository, {super.key});

  @override
  State<OgretmenlerSayfasi> createState() => _OgretmenlerSayfasiState();
}

class _OgretmenlerSayfasiState extends State<OgretmenlerSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğretmenler'),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 32.0),
                child: Text(
                    '${widget.ogretmenRepository.ogretmenler.length} Öğretmen'),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => OgretmenSatiri(
                      widget.ogretmenRepository.ogretmenler[index],
                      widget.ogretmenRepository,
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: widget.ogretmenRepository.ogretmenler.length),
          ),
        ],
      ),
    );
  }
}

class OgretmenSatiri extends StatefulWidget {
  final Ogretmen ogretmen;
  final OgretmenRepository ogretmenRepository;
  const OgretmenSatiri(
    this.ogretmen,
    this.ogretmenRepository, {
    Key? key,
  }) : super(key: key);

  @override
  State<OgretmenSatiri> createState() => _OgretmenSatiriState();
}

class _OgretmenSatiriState extends State<OgretmenSatiri> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.ogretmen.ad} ${widget.ogretmen.soyad}'),
      leading: IntrinsicWidth(
          child: Center(
              child: Text(widget.ogretmen.cinsiyet == 'Kadın'
                  ? '🙎🏻‍♀️'
                  : '🙎🏻‍♂️'))), //🙎🏻‍♂️
    );
  }
}
