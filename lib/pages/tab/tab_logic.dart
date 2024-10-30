import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/pages/other/other_logic.dart';
import 'package:schedule/pages/schedule/schedule_logic.dart';

class TabLogic extends GetxController {

  PageController pageController = PageController();
  var currentIndex = 0.obs;

  ScheduleLogic scheduleLogic = Get.find<ScheduleLogic>();
  OtherLogic otherLogic = Get.find<OtherLogic>();

}
