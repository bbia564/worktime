import 'package:get/get.dart';

import 'all_logic.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllLogic());
  }
}
