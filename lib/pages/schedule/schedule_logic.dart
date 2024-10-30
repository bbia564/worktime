import 'package:get/get.dart';
import 'package:schedule/db_rr/db_rr.dart';

import '../../db_rr/schedule_entity.dart';

class ScheduleLogic extends GetxController {
  final dbRR = Get.find<DBRR>();

  var morningList = <ScheduleEntity>[].obs;
  var afternoonList = <ScheduleEntity>[].obs;
  var todayDuring = '-'.obs;
  var todayCount = '-'.obs;
  var todayPrice = '-'.obs;

  void getData() async {
    dbRR.getAllData().then((value) {
      var doingList =
          value.where((element) => element.workStatus == 0).toList();
      var finishList =
          value.where((element) => element.workStatus == 1).toList();
      morningList.value =
          doingList.where((element) => element.workType == 0).toList();
      afternoonList.value =
          doingList.where((element) => element.workType == 1).toList();
      todayDuring.value = value.isEmpty
          ? '-'
          : '${value
              .map((e) => e.workDuring)
              .reduce((value, element) => value + element)}Hours';
      todayCount.value = finishList.isEmpty
          ? '-'
          : '${finishList
              .map((e) => e.workDuring)
              .reduce((value, element) => value + element)}Hours';
      todayPrice.value = finishList.isEmpty
          ? '-'
          : finishList
              .map((e) => e.price)
              .reduce((value, element) => value + element)
              .toString();
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
