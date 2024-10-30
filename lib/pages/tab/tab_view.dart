import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/pages/add/add_view.dart';
import 'package:schedule/pages/other/other_view.dart';
import 'package:schedule/pages/schedule/schedule_view.dart';

import '../../main.dart';
import 'tab_logic.dart';

class TabPage extends GetView<TabLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          SchedulePage(),
          AddPage(),
          OtherPage(),
        ],
      ),
      bottomNavigationBar: Obx(()=>_navBars()),
    );
  }

  Widget _navBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon:const Icon(Icons.home,color: Colors.grey,),
          activeIcon: Icon(Icons.home,color: primaryColor,),
          label: 'My schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle,color: primaryColor,size: 40,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon:const Icon(Icons.settings,color: Colors.grey,),
          activeIcon: Icon(Icons.settings,color: primaryColor,),
          label: 'Other',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        if (index == 1) {
          Get.bottomSheet(AddPage())?.then((_){
            controller.scheduleLogic.getData();
            controller.otherLogic.getData();
          });
        } else {
          controller.currentIndex.value = index;
          controller.pageController.jumpToPage(index);
          controller.scheduleLogic.getData();
          controller.otherLogic.getData();
        }
      },
    );
  }
}
