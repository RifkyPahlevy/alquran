import 'dart:convert';

import 'package:alquran/app/data/model/surah.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../constant/colors.dart';
import '../../../data/model/detailsurah.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  RxBool isDark = false.obs;
  void changeTheme() {
    Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);
    isDark.toggle();
    if (Get.isDarkMode) {
      box.remove("themeDark");
    } else {
      box.write("themeDark", "");
    }
  }

  List<Surah> allSurah = [];

  Future<List<Surah>> getSurah() async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah");

    var res = await http.get(url);

    List data = (json.decode(res.body) as Map<String, dynamic>)['data'];

    if (data == null) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah;
    }
  }

  Future<List<Map<String, dynamic>>> getDetailJuz() async {
    int juz = 1;

    List<Map<String, dynamic>> tempAyat = [];
    List<Map<String, dynamic>> allJuz = [];
    for (var i = 1; i <= 114; i++) {
      var res =
          await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/$i"));

      Map<String, dynamic> data = json.decode(res.body)["data"];
      DetailSurah detailSurah = DetailSurah.fromJson(data);

      if (detailSurah.verses != null) {
        detailSurah.verses!.forEach((ayat) {
          if (ayat.meta!.juz == juz) {
            tempAyat.add({
              "surah": detailSurah,
              "ayat": ayat,
            });
          } else {
            allJuz.add({
              "juz": juz,
              "surah": detailSurah.name!.transliteration!.id,
              "start": tempAyat[0],
              "end": tempAyat[tempAyat.length - 1],
              "verses": tempAyat
            });
            juz++;
            tempAyat = [];
            tempAyat.add({
              "surah": detailSurah,
              "ayat": ayat,
            });
          }
        });
      }
    }

    allJuz.add({
      "juz": juz,
      "start": tempAyat[0],
      "end": tempAyat[tempAyat.length - 1],
      "verses": tempAyat
    });
    return allJuz;
  }
}
