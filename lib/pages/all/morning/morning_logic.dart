import 'package:get/get.dart';
import 'package:schedule/db_rr/schedule_entity.dart';

import '../../../db_rr/db_rr.dart';

class MorningLogic extends GetxController {

  final dbRR = Get.find<DBRR>();

  var morningList = <ScheduleEntity>[].obs;

  void getData() async {
    final list = await dbRR.getAllData();
    morningList.value = list.where((e) => e.workType == 0).toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
