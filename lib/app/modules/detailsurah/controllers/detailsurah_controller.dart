import 'dart:convert';

import 'package:alquran/app/data/model/db/databasemanager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/model/detailsurah.dart';
import 'package:http/http.dart' as http;

class DetailsurahController extends GetxController {
  final player = AudioPlayer();

  Future<DetailSurah> getDetailSurah(int number) async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah/$number");
    var res = await http.get(url);
    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)['data'];

    return DetailSurah.fromJson(data);
  }

  DatabaseManager database = DatabaseManager.instance;

  void addBookmark(
      bool isBookmark, Verses ayat, int index, DetailSurah surah) async {
    Database db = await database.db;

    bool flagExist = false;
    if (isBookmark == true) {
      db.delete("bookmark", where: "last_read = 1 ");
    } else {
      List checkData = await db.query("bookmark",
          where:
              "surah = '${surah.name!.transliteration!.id}' and ayat = ${ayat.number!.inSurah} and juz = ${ayat.meta!.juz!} and via = 'Surah' and index_ayat = $index and last_read = 0");

      if (checkData.length != 0) {
        flagExist = true;
      }
    }
    if (flagExist == false) {
      db.insert("bookmark", {
        'surah': surah.name!.transliteration!.id,
        'ayat': ayat.number!.inSurah,
        'juz': ayat.meta!.juz!,
        'via': "Surah",
        'index_ayat': index,
        'last_read': isBookmark == true ? 1 : 0,
      });

      Get.back();
      Get.snackbar(
        "Berhasil",
        "Surah telah ditambahkan ke bookmark",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.back();
      Get.snackbar(
        "Terjadi Kesalahan",
        "Surah tidak ditambahkan ke bookmark",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      );
    }
  }

  void playAudio(Verses ayat) async {
    try {
      await player.stop();

      update();
      await player.setUrl("${ayat.audio!.primary}");
      ayat.button = "playing";
      update();
      await player.play();

      ayat.button = "stop";
      await player.stop();
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e.message}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e.message}",
      );
    } catch (e) {
      // Fallback for all errors
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e}",
      );
    }
  }

  void pauseAudio(Verses ayat) async {
    try {
      await player.pause();
      ayat.button = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e.message}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e.message}",
      );
    } catch (e) {
      // Fallback for all errors
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e}",
      );
    }
  }

  void resumeAudio(Verses ayat) async {
    try {
      ayat.button = "playing";
      update();
      await player.play();

      ayat.button = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e.message}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e.message}",
      );
    } catch (e) {
      // Fallback for all errors
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e}",
      );
    }
  }

  void stopAudio() async {
    try {
      //button.value = "stop";
      await player.stop();
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e.message}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e.message}",
      );
    } catch (e) {
      // Fallback for all errors
      Get.defaultDialog(
        title: "Audio Tidak dapat diputar",
        middleText: "${e}",
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    super.onClose();
  }
}
