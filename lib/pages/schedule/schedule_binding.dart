import 'package:get/get.dart';

import 'schedule_logic.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScheduleLogic());
  }
}
