import 'package:alquran/app/constant/colors.dart';
import 'package:alquran/app/data/model/detailsurah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detailjuz_controller.dart';

class DetailjuzView extends GetView<DetailjuzController> {
  final Map<String, dynamic> detailJuz = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Juz ${detailJuz["juz"] ?? ""}"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (detailJuz['verses'] as List).length,
            itemBuilder: (context, index) {
              // var detail = snapshot.data!.verses![index];

              if ((detailJuz['verses'] as List).length == 0) {
                Center(
                  child: Text("Tidak ada ayat"),
                );
              }

              Map<String, dynamic> ayat = detailJuz['verses'][index];
              DetailSurah surah = ayat["surah"];
              Verses ayatJuz = ayat["ayat"];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if ((ayat['ayat'] as Verses).number?.inSurah == 1)
                    InkWell(
                      onTap: () {
                        Get.dialog(Dialog(
                          child: Container(
                            color: Get.isDarkMode
                                ? appPurple.withOpacity(0.2)
                                : appWhite,
                            padding: EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Tafsir Surah ${surah.name?.transliteration?.id ?? "Tafsir tidak tersedia"}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${surah.tafsir?.id ?? "Tafsir tidak tersedia"}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: Get.height * 0.3,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.white54, appPurple])),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -20,
                              bottom: -20,
                              child: Container(
                                height: 200,
                                child: Image.asset(
                                  "assets/images/quran.png",
                                  fit: BoxFit.contain,
                                  color: Colors.purple.withOpacity(0.3),
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${surah.name?.transliteration?.id ?? "null"}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "( ${surah.name?.translation?.id ?? "null"} )",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "${surah.numberOfVerses ?? "null"} ayat | ${surah.revelation?.id ?? "null"} ",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    color: appPurple.withOpacity(0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: Text(
                              "${(ayat['ayat'] as Verses).number?.inSurah ?? ""}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/ayat.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        GetBuilder<DetailjuzController>(
                          builder: (c) => Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: "silahkan pilih",
                                      content: Text(
                                          "Apakah anda ingin menyimpan ayat ini?"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Text("Last_read")),
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Text("Surah"))
                                      ]);
                                },
                                icon: Icon(Icons.bookmark_add_outlined),
                              ),
                              (ayatJuz.button == "stop")
                                  ? IconButton(
                                      onPressed: () async {
                                        c.playAudio(ayatJuz);
                                      },
                                      icon: Icon(Icons.play_arrow),
                                    )
                                  : Row(
                                      children: [
                                        (ayatJuz.button == "playing")
                                            ? IconButton(
                                                onPressed: () async {
                                                  c.pauseAudio(ayatJuz);
                                                },
                                                icon: Icon(Icons.pause))
                                            : IconButton(
                                                onPressed: () async {
                                                  controller
                                                      .resumeAudio(ayatJuz);
                                                },
                                                icon: Icon(
                                                    Icons.play_arrow_outlined),
                                              ),
                                        IconButton(
                                          onPressed: () async {
                                            controller.stopAudio();
                                          },
                                          icon: Icon(Icons.stop),
                                        )
                                      ],
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${(ayat['ayat'] as Verses).text?.arab ?? "null"}",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${(ayat['ayat'] as Verses).text?.transliteration?.en ?? "null"}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "${(ayat['ayat'] as Verses).translation?.id ?? "null"}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
