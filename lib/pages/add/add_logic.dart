import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schedule/db_rr/schedule_entity.dart';

import '../../db_rr/db_rr.dart';

class AddLogic extends GetxController {

  final dbRR = Get.find<DBRR>();

  bool isAdd = true;
  bool hadCommit = false;

  var workType = 0.obs;
  var workStatus = 0.obs;

  ScheduleEntity? entity;

  void imageSelected() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        entity?.imageData = imageBytes;
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Please try again with a different image');
      return;
    }

  }


  void commit(BuildContext context) async {
    if (entity?.imageData == null) {
      Fluttertoast.showToast(msg: 'Please select image');
      return;
    }
    if (entity?.name == '') {
      Fluttertoast.showToast(msg: 'Please enter a cell name');
      return;
    }
    if (entity?.chargePerson == '') {
      Fluttertoast.showToast(msg: 'Please enter the responsible information');
      return;
    }
    if (entity?.construction == 0) {
      Fluttertoast.showToast(msg: 'Please enter the correct estimated duration');
      return;
    }
    if (entity?.workDuring == 0) {
      Fluttertoast.showToast(msg: 'Please enter the correct working hours');
      return;
    }
    if (entity?.price == 0) {
      Fluttertoast.showToast(msg: 'Please enter the payment for the work');
      return;
    }
    if (hadCommit) {
      return;
    }
    if (!hadCommit) {
      hadCommit = true;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    entity?.createdTime = DateTime.now();
    if (isAdd) {
      dbRR.addSchedule(entity!);
    } else {
      dbRR.updateSchedule(entity!);
    }
    Get.back();

  }


}
