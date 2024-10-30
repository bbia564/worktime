import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../add/add_view.dart';
import '../../schedule/work_item.dart';
import 'afternoon_logic.dart';

class AfternoonPage extends StatefulWidget {
  @override
  State<AfternoonPage> createState() => _AfternoonPageState();
}

class _AfternoonPageState extends State<AfternoonPage> {
  final controller = Get.put(AfternoonLogic());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return controller.afternoonList.isEmpty
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
                      'No record',
                      style: TextStyle(color: Colors.grey),
                    )
                  ].toColumn(),
                ).constrained(maxHeight: 100),
              )
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.afternoonList.length,
                itemBuilder: (_, index) {
                  final entity = controller.afternoonList[index];
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
    Get.delete<AfternoonLogic>();
    super.dispose();
  }
}
