import 'package:get/get.dart';

import '../controllers/detailsurah_controller.dart';

class DetailsurahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsurahController>(
      () => DetailsurahController(),
    );
  }
}
