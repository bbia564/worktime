import 'package:get/get.dart';
import 'package:schedule/pages/other/other_logic.dart';
import 'package:schedule/pages/schedule/schedule_logic.dart';

import '../add/add_logic.dart';
import 'tab_logic.dart';

class TabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabLogic());
    Get.lazyPut(() => ScheduleLogic());
    Get.lazyPut(() => AddLogic());
    Get.lazyPut(() => OtherLogic());
  }
}
