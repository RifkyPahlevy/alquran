import 'package:get/get.dart';

import '../controllers/detailayat_controller.dart';

class DetailayatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailayatController>(
      () => DetailayatController(),
    );
  }
}
