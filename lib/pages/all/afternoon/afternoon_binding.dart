import 'package:get/get.dart';

import 'afternoon_logic.dart';

class AfternoonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AfternoonLogic());
  }
}
