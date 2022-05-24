import 'package:alquran/app/data/model/detailsurah.dart';
import 'package:alquran/app/data/model/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detailayat_controller.dart';

class DetailayatView extends GetView<DetailayatController> {
  @override
  Widget build(BuildContext context) {
    Verses detail = Get.arguments["ayat"];
    Surah surah = Get.arguments["surah"];

    return Scaffold(
        appBar: AppBar(
          title: Text('Tafsir Surah ${surah.name!.transliteration!.id}'),
          centerTitle: true,
        ),
        body: ListView(
            padding: EdgeInsets.all(20),
            children: [Text("${detail.tafsir?.id ?? "null"}")]));
  }
}
