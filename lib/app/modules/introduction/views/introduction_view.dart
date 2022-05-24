import 'package:alquran/app/constant/colors.dart';
import 'package:alquran/app/routes/app_pages.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Al-Quran App',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Seberapa sibukkah kamu sampai lupa membaca Al Quran?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: Get.height * 0.4,
              width: Get.width * 0.7,
              child: Lottie.asset("assets/lotties/animasi-quran.json"),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: appWhite),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Get.isDarkMode ? appWhite : appPurple,
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => Get.offAllNamed(Routes.HOME),
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: Get.isDarkMode ? appPurple : appWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
