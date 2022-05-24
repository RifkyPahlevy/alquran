import 'package:alquran/app/modules/detailayat/bindings/detailayat_binding.dart';
import 'package:alquran/app/modules/detailayat/views/detailayat_view.dart';
import 'package:alquran/app/modules/detailjuz/bindings/detailjuz_binding.dart';
import 'package:alquran/app/modules/detailjuz/views/detailjuz_view.dart';
import 'package:alquran/app/modules/detailsurah/bindings/detailsurah_binding.dart';
import 'package:alquran/app/modules/detailsurah/views/detailsurah_view.dart';
import 'package:alquran/app/modules/home/bindings/home_binding.dart';
import 'package:alquran/app/modules/home/views/home_view.dart';
import 'package:alquran/app/modules/introduction/bindings/introduction_binding.dart';
import 'package:alquran/app/modules/introduction/views/introduction_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.DETAILSURAH,
      page: () => DetailsurahView(),
      binding: DetailsurahBinding(),
    ),
    GetPage(
      name: _Paths.DETAILAYAT,
      page: () => DetailayatView(),
      binding: DetailayatBinding(),
    ),
    GetPage(
      name: _Paths.DETAILJUZ,
      page: () => DetailjuzView(),
      binding: DetailjuzBinding(),
    ),
  ];
}
