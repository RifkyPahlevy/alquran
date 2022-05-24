import 'package:get/get.dart';

import '../controllers/detailjuz_controller.dart';

class DetailjuzBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailjuzController>(
      () => DetailjuzController(),
    );
  }
}
