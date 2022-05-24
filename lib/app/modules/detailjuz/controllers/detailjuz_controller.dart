import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/model/juz.dart';
import '../../../data/model/detailsurah.dart' as detailSurah;

class DetailjuzController extends GetxController {
  int index = 0;
  final player = AudioPlayer();

  Future<Juz> getDetailJuz(int id) async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/juz/$id");

    var res = await http.get(url);
    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)['data'];

    return Juz.fromJson(data);
  }

  void playAudio(detailSurah.Verses ayat) async {
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

  void pauseAudio(detailSurah.Verses ayat) async {
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

  void resumeAudio(detailSurah.Verses ayat) async {
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
}
