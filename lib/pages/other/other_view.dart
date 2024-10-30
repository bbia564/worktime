import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'other_logic.dart';

class OtherPage extends GetView<OtherLogic> {
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
      appBar: AppBar(
        title: const Text('Other'),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
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
                        topText: controller.allDuring.value,
                        bottomText: 'Total duration'),
                    topWidget(
                        topText: controller.allCount.value,
                        bottomText: 'Total completion'),
                    topWidget(
                        topText: controller.allPrice.value,
                        bottomText: 'Total payment')
                  ].toRow(crossAxisAlignment: CrossAxisAlignment.center);
                }),
              ).decorated(
                  color: primaryColor, borderRadius: BorderRadius.circular(12)),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: <Widget>[
                  GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      height: 40,
                      child: <Widget>[
                        const Text('Delete record'),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                          size: 20,
                        )
                      ].toRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    onTap: () {
                      controller.cleanRecords();
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      height: 40,
                      child: <Widget>[
                        const Text('About APP'),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                          size: 20,
                        )
                      ].toRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    onTap: () {
                      controller.aboutAPP(context);
                    },
                  )
                ].toColumn(
                    separator: Divider(
                  height: 15,
                  color: Colors.grey.withOpacity(0.4),
                )),
              )
                  .decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12))
                  .marginOnly(top: 15)
            ].toColumn(),
          ))),
    );
  }
}
