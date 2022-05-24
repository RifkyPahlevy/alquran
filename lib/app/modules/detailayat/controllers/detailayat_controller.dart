import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/model/ayat.dart';

class DetailayatController extends GetxController {
  Future<Ayat> getDetailAyat(int number, int ayat) async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah/$number/$ayat");

    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)['data'];

    return Ayat.fromJson(data);
  }
}
