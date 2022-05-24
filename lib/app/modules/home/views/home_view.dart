import 'package:alquran/app/constant/colors.dart';
import 'package:alquran/app/data/model/detailsurah.dart';
import 'package:alquran/app/data/model/surah.dart';
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: Icon(Icons.line_weight_sharp)),
        title: Text('Al Quran App'),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamualaikum",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -25,
                        bottom: -30,
                        child: Container(
                            height: 130,
                            width: 150,
                            child: Image.asset(
                              "assets/images/quran.png",
                              fit: BoxFit.contain,
                            )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.menu_book_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Last Read",
                                style: TextStyle(color: appWhite),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Al-Fatihah",
                              style: TextStyle(
                                  color: appWhite,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Ayat 1",
                            style: TextStyle(color: appWhite),
                          )
                        ],
                      )
                    ],
                  ),
                  width: Get.width,
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [
                        appPurple3,
                        appPurpleLight,
                      ],
                    ),
                  ),
                ),
              ),
              TabBar(
                  unselectedLabelColor: appGrey,
                  indicatorColor: appPurpleDark,
                  tabs: [
                    Tab(
                      text: "Surah",
                    ),
                    Tab(
                      text: "Juz",
                    ),
                    Tab(
                      text: "Bookmark",
                    ),
                  ]),
              Expanded(
                  child: TabBarView(children: [
                FutureBuilder<List<Surah>>(
                  future: controller.getSurah(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('Data tidak ditemukan'),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Surah surah = snapshot.data![index];
                        return ListTile(
                          leading: Container(
                            child: Center(
                              child: Text("${surah.number}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/ayat.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () =>
                              Get.toNamed(Routes.DETAILSURAH, arguments: surah),
                          title: Text("${surah.name!.transliteration!.id}"),
                          subtitle: Row(
                            children: [
                              Text("${surah.revelation!.id}"),
                              SizedBox(
                                width: 5,
                              ),
                              Text("${surah.numberOfVerses} ayat"),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: controller.getDetailJuz(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data! == null) {
                      return Center(
                        child: Text('Data tidak ditemukan'),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> detailJuz = snapshot.data![index];
                        return ListTile(
                          leading: Container(
                            child: Center(
                              child: Text("${index + 1}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/ayat.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(Routes.DETAILJUZ, arguments: detailJuz);
                          },
                          title: Text("Juz ${index + 1}"),
                          isThreeLine: true,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "mulai dari ${(detailJuz['start']['surah'] as DetailSurah).name?.transliteration?.id ?? ""} ayat ${(detailJuz['start']['ayat'] as Verses).number?.inSurah ?? ""}"),
                              Text(
                                  "sampai ${(detailJuz['end']['surah'] as DetailSurah).name?.transliteration?.id ?? ""} ayat ${(detailJuz['end']['ayat'] as Verses).number?.inSurah ?? ""} "),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                Center(
                  child: Text("Bookmark"),
                ),
              ]))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeTheme(),
        child: Obx(() => Icon(
              Icons.color_lens_rounded,
              color: controller.isDark.value ? appWhite : appPurple,
            )),
      ),
    );
  }
}
