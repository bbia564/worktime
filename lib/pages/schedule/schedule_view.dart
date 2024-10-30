import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/main.dart';
import 'package:schedule/pages/add/add_view.dart';
import 'package:schedule/pages/schedule/work_item.dart';
import 'package:styled_widget/styled_widget.dart';

import 'schedule_logic.dart';

class SchedulePage extends GetView<ScheduleLogic> {
  Widget topWidget({String topText = '-', String bottomText = ''}) {
    return Expanded(
        child: <Widget>[
      Text(
        topText,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        bottomText,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      )
    ].toColumn(mainAxisAlignment: MainAxisAlignment.center));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('My schedule')),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  height: 88,
                  child: Obx(() {
                    return <Widget>[
                      topWidget(
                          topText: controller.todayDuring.value,
                          bottomText: '''Today's duration'''),
                      topWidget(
                          topText: controller.todayCount.value,
                          bottomText: 'Finish today'),
                      topWidget(
                          topText: controller.todayPrice.value,
                          bottomText: '''Today's payment''')
                    ].toRow(crossAxisAlignment: CrossAxisAlignment.center);
                  }),
                ).decorated(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12)),
                <Widget>[
                  <Widget>[
                    Image.asset(
                      'assets/worker.webp',
                      width: 13,
                      height: 13,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Morning construction',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ].toRow(),
                  GestureDetector(
                    child: <Widget>[
                      const Text(
                        'All',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ].toRow(),
                    onTap: () {
                      Get.toNamed('/all',arguments: 0)?.then((value) {
                        controller.getData();
                      });
                    },
                  )
                ]
                    .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                    .marginSymmetric(vertical: 15),
                Obx(() {
                  return controller.morningList.isEmpty
                      ? Container(
                          width: double.infinity,
                          child: <Widget>[
                            Image.asset(
                              'assets/noData.webp',
                              width: 52,
                              height: 56,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'No record',
                              style: TextStyle(color: Colors.grey),
                            )
                          ].toColumn(),
                        ).constrained(maxHeight: 100)
                      : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                          itemCount: controller.morningList.length,
                          itemBuilder: (_, index) {
                            final entity = controller.morningList[index];
                            return GestureDetector(child: WorkItem(entity),onTap: () {
                              Get.bottomSheet(AddPage(entity: entity));
                            },);
                          });
                }),
                <Widget>[
                  <Widget>[
                    Image.asset(
                      'assets/worker.webp',
                      width: 13,
                      height: 13,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Afternoon construction',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ].toRow(),
                  GestureDetector(
                    child: <Widget>[
                      const Text(
                        'All',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ].toRow(),
                    onTap: () {
                      Get.toNamed('/all',arguments: 1)?.then((value) {
                        controller.getData();
                      });
                    },
                  )
                ]
                    .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                    .marginSymmetric(vertical: 15),
                Obx(() {
                  return controller.afternoonList.isEmpty
                      ? Container(
                    width: double.infinity,
                    child: <Widget>[
                      Image.asset(
                        'assets/noData.webp',
                        width: 52,
                        height: 56,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'No record',
                        style: TextStyle(color: Colors.grey),
                      )
                    ].toColumn(),
                  ).constrained(maxHeight: 100)
                      : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.afternoonList.length,
                      itemBuilder: (_, index) {
                        final entity = controller.afternoonList[index];
                        return GestureDetector(child: WorkItem(entity),onTap: () {
                          Get.bottomSheet(AddPage(entity: entity));
                        },);
                      });
                })
              ].toColumn(),
            ),
          )).marginAll(12),
    );
  }
}
