import 'package:alquran/app/constant/colors.dart';
import 'package:alquran/app/data/model/detailsurah.dart';
import 'package:alquran/app/data/model/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/detailsurah_controller.dart';

class DetailsurahView extends GetView<DetailsurahController> {
  Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surah ${surah.name!.transliteration!.id}'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Get.dialog(Dialog(
                child: Container(
                  color: Get.isDarkMode ? appPurple.withOpacity(0.2) : appWhite,
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
                  gradient:
                      LinearGradient(colors: [Colors.white54, appPurple])),
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
                        Text("( ${surah.name?.translation?.id ?? "null"} )",
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
                        FutureBuilder<DetailSurah>(
                            future: controller.getDetailSurah(surah.number!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.data == null) {
                                return Center(
                                  child: Text(""),
                                );
                              }
                              return Text(
                                  " ${snapshot.data?.preBismillah?.text?.arab ?? ""} ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold));
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder<DetailSurah>(
              future: controller.getDetailSurah(surah.number!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return Center(
                    child: Text("Data tidak ditemukan"),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: surah.numberOfVerses,
                  itemBuilder: (context, index) {
                    var detail = snapshot.data!.verses![index];

                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETAILAYAT,
                            arguments: {"surah": surah, "ayat": detail});
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                                      "${detail.number?.inSurah ?? "null"}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/ayat.png"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                GetBuilder<DetailsurahController>(
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
                                                    onPressed: () {
                                                      c.addBookmark(
                                                          true,
                                                          detail,
                                                          index,
                                                          snapshot.data!);
                                                    },
                                                    child: Text("Last_read")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      c.addBookmark(
                                                          false,
                                                          detail,
                                                          index,
                                                          snapshot.data!);
                                                    },
                                                    child: Text("Surah"))
                                              ]);
                                        },
                                        icon: Icon(Icons.bookmark_add_outlined),
                                      ),
                                      (detail.button == "stop")
                                          ? IconButton(
                                              onPressed: () async {
                                                c.playAudio(detail);
                                              },
                                              icon: Icon(Icons.play_arrow),
                                            )
                                          : Row(
                                              children: [
                                                (detail.button == "playing")
                                                    ? IconButton(
                                                        onPressed: () async {
                                                          c.pauseAudio(detail);
                                                        },
                                                        icon: Icon(Icons.pause))
                                                    : IconButton(
                                                        onPressed: () async {
                                                          controller
                                                              .resumeAudio(
                                                                  detail);
                                                        },
                                                        icon: Icon(Icons
                                                            .play_arrow_outlined),
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
                            "${detail.text?.arab ?? "null"}",
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
                            "${detail.text?.transliteration?.en ?? "null"}",
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
                              "${detail.translation?.id ?? "null"}",
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
                      ),
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}
