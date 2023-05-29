import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:ogrenci_app/models/ogretmen.dart';
import 'package:ogrenci_app/services/data_services.dart';

class OgretmenForm extends ConsumerStatefulWidget {
  const OgretmenForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OgretmenFormState createState() => _OgretmenFormState();
}

class _OgretmenFormState extends ConsumerState<OgretmenForm> {
  final Map<String, dynamic> girilen = {};
  final _formkey = GlobalKey<FormState>();

  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Öğretmen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Ad'),
                  ),
                  // ignore: body_might_complete_normally_nullable
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return 'Ad girmeniz gerekli';
                    }
                  },
                  onSaved: (newValue) {
                    girilen['ad'] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Soyad'),
                  ),
                  // ignore: body_might_complete_normally_nullable
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return 'Soyad girmeniz gerekli';
                    }
                  },
                  onSaved: (newValue) {
                    girilen['soyad'] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Yaş'),
                  ),
                  // ignore: body_might_complete_normally_nullable
                  validator: (value) {
                    if (value == null || value.isNotEmpty != true) {
                      return 'Yaş girmeniz gerekli';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Rakamlarla yaş girmeniz gerekli';
                    }
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    girilen['yas'] = int.parse(newValue!);
                  },
                ),
                DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      // ignore: sort_child_properties_last
                      child: Text('Erkek'),
                      value: 'Erkek',
                    ),
                    DropdownMenuItem(
                      // ignore: sort_child_properties_last
                      child: Text('Kadın'),
                      value: 'Kadın',
                    ),
                  ],
                  value: girilen['cinsiyet'],
                  onChanged: (value) {
                    setState(() {
                      girilen['cinsiyet'] = value;
                    });
                  },
                  // ignore: body_might_complete_normally_nullable
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen bir cinsiyet seçin';
                    }
                  },
                ),
                isSaving
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          final formstate = _formkey.currentState;
                          if (formstate == null) return;
                          if (formstate.validate() == true) {
                            formstate.save();
                            if (kDebugMode) {
                              print(girilen);
                            }
                          }
                          _kaydet();
                        },
                        child: const Text('Kaydet'),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _kaydet() async {
    try {
      setState(() {
        isSaving = true;
      });
      await ref.read(dataServiceProvider).ogretmenEkle(
            Ogretmen.fromMap(girilen),
          );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Öpretmen kaydedildi')));

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }
}
