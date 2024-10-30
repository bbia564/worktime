import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../db_rr/db_rr.dart';
import '../../db_rr/schedule_entity.dart';

class OtherLogic extends GetxController {

  final dbRR = Get.find<DBRR>();

  var allDuring = '-'.obs;
  var allCount = '-'.obs;
  var allPrice = '-'.obs;

  void getData() async {
    dbRR.getAllData().then((value) {
      var resultList = value;
      var finishList =
      resultList.where((element) => element.workStatus == 1).toList();
      allDuring.value = resultList.isEmpty
          ? '-'
          : '${resultList
          .map((e) => e.construction)
          .reduce((value, element) => value + element)*24}Hours';
      allCount.value = finishList.isEmpty
          ? '-'
          : '${finishList
          .map((e) => e.workDuring)
          .reduce((value, element) => value + element)}Hours';
      allPrice.value = resultList.isEmpty
          ? '-'
          : '${resultList
          .map((e) => e.price)
          .reduce((value, element) => value + element)}';

    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  cleanRecords() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to erase all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            dbRR.cleanAllData();
            getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutAPP(BuildContext context) async {
    final info = await PackageInfo.fromPlatform();
    showAboutDialog(
      context: context,
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/image.png',
        width: 70,
        height: 70,
      ),
      children: [
        const Text(
            """A simple and efficient recording tool"""),
      ],
    );
  }

  aboutPrivacy(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Privacy Policy"),
          ),
          body: const Markdown(data: """
#### Data Collection
Our apps do not collect any personal information or user data. All event logs are executed locally on the device and are not transmitted to any external server.

#### Cookie Usage
Our app does not use any form of cookies or similar technologies to track user behavior or personal information.

#### Data Security
User input data is only used for calculations on the user's device and is not stored or transmitted. We are committed to ensuring the security of user data.
          """),
        );
      },
    );
  }
}
