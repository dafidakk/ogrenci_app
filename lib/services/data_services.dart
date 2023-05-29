import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/models/ogretmen.dart';

class DataServices {
  final String baseUrl = 'https://6460a44bca2d89f7e75be835.mockapi.io/';
  Future<Ogretmen> ogretmenIndir() async {
    final response = await http.get(Uri.parse('$baseUrl/ogretmen/1'));

    if (response.statusCode == 200) {
      return Ogretmen.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Ogretmen indirilemedi ${response.statusCode}');
    }
  }

  Future<void> ogretmenEkle(Ogretmen ogretmen) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ogretmen'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(ogretmen.toMap()),
    );
    if (response.statusCode == 201) {
      return ;
    } else {
      throw Exception('Ogretmen eklenemedi ${response.statusCode}');
    }
  }
}

final dataServiceProvider = Provider((ref) {
  return DataServices();
});
