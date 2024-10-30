import 'package:get/get.dart';

import '../../../db_rr/db_rr.dart';
import '../../../db_rr/schedule_entity.dart';

class AfternoonLogic extends GetxController {

  final dbRR = Get.find<DBRR>();

  var afternoonList = <ScheduleEntity>[].obs;

  void getData() async {
    final list = await dbRR.getAllData();
    afternoonList.value = list.where((e) => e.workType == 1).toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
