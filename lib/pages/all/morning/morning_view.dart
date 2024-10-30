import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/pages/schedule/work_item.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../add/add_view.dart';
import 'morning_logic.dart';

class MorningPage extends StatefulWidget {
  @override
  State<MorningPage> createState() => _MorningPageState();
}

class _MorningPageState extends State<MorningPage> {
  final controller = Get.put(MorningLogic());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return controller.morningList.isEmpty
            ? Center(
                child: Container(
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
                      'No record yet',
                      style: TextStyle(color: Colors.grey),
                    )
                  ].toColumn(),
                ).constrained(maxHeight: 100),
              )
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.morningList.length,
                itemBuilder: (_, index) {
                  final entity = controller.morningList[index];
                  return GestureDetector(
                    child: WorkItem(entity),
                    onTap: () {
                      Get.bottomSheet(AddPage(entity: entity))?.then((value) {
                        controller.getData();
                      });
                    },
                  );
                });
      }),
    );
  }

  @override
  void dispose() {
    Get.delete<MorningLogic>();
    super.dispose();
  }
}
