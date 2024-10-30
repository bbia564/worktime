import 'package:get/get.dart';

import 'morning_logic.dart';

class MorningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MorningLogic());
  }
}
