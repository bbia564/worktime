import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/db_rr/schedule_entity.dart';
import 'package:schedule/main.dart';
import 'package:schedule/pages/add/rr_text_field.dart';
import 'package:styled_widget/styled_widget.dart';

import 'add_logic.dart';

class AddPage extends StatefulWidget {
  AddPage({this.entity, Key? key}) : super(key: key);

  ScheduleEntity? entity;

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  AddLogic controller = Get.put(AddLogic());

  @override
  void initState() {
    // TODO: implement initState
    controller.isAdd = widget.entity == null;
    if (widget.entity == null) {
      controller.entity = ScheduleEntity(
          id: 0,
          createdTime: DateTime.now(),
          name: '',
          chargePerson: '',
          construction: 0,
          workType: 0,
          workDuring: 0,
          price: 0,
          workStatus: 0);
    } else {
      controller.entity = widget.entity;
    }
    controller.workType.value = controller.entity?.workType ?? 0;
    controller.workStatus.value = controller.entity?.workStatus ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      width: double.infinity,
      height: 400,
      child: GetBuilder<AddLogic>(builder: (_) {
        return SafeArea(
          child: <Widget>[
            Container(
              width: double.infinity,
              height: 40,
              child: <Widget>[
                GestureDetector(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                Text(
                  controller.isAdd ? 'Add schedule' : 'Edit schedule',
                  style: const TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  child: Text(
                    'Commit',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    controller.commit(context);
                  },
                )
              ].toRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            Divider(
              height: 20,
              color: Colors.grey.withOpacity(0.4),
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                <Widget>[
                  <Widget>[
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Community Photo',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 63,
                          height: 55,
                          child: controller.entity?.imageData == null
                              ? Image.asset(
                                  'assets/noImage.webp',
                                  width: 23,
                                  height: 17,
                                )
                              : Image.memory(
                                  controller.entity!.imageData!,
                                  fit: BoxFit.cover,
                                ),
                        ).decorated(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onTap: () {
                        controller.imageSelected();
                      },
                    )
                  ].toRow(),
                  Divider(
                    height: 15,
                    indent: 120,
                    color: Colors.grey.withOpacity(0.4),
                  )
                ].toColumn(),
                <Widget>[
                  <Widget>[
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Community name',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 40,
                      child: RRTextField(
                          padding: EdgeInsets.zero,
                          value: controller.entity?.name ?? '',
                          maxLength: 11,
                          onChange: (value) {
                            controller.entity?.name = value;
                          }),
                    ))
                  ].toRow(),
                  Divider(
                    height: 15,
                    indent: 120,
                    color: Colors.grey.withOpacity(0.4),
                  )
                ].toColumn(),
                <Widget>[
                  <Widget>[
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'In charge',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 40,
                      child: RRTextField(
                          padding: EdgeInsets.zero,
                          maxLength: 18,
                          value: controller.entity?.chargePerson ?? '',
                          keyboardType: TextInputType.phone,
                          onChange: (value) {
                            controller.entity?.chargePerson = value;
                          }),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/contact.webp',
                      width: 17,
                      height: 18,
                    )
                  ].toRow(),
                  Divider(
                    height: 15,
                    indent: 120,
                    color: Colors.grey.withOpacity(0.4),
                  )
                ].toColumn(),
                <Widget>[
                  <Widget>[
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Forecast work duration',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 40,
                      child: RRTextField(
                          padding: EdgeInsets.zero,
                          maxLength: 5,
                          value: (controller.entity?.construction != 0 &&
                                  controller.entity?.construction != null)
                              ? controller.entity?.construction.toString() ?? ''
                              : '',
                          isInteger: true,
                          onChange: (value) {
                            controller.entity?.construction =
                                value.isEmpty ? 0 : (int.tryParse(value) ?? 0);
                          }),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Day',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ].toRow(),
                  Divider(
                    height: 15,
                    indent: 120,
                    color: Colors.grey.withOpacity(0.4),
                  )
                ].toColumn(),
                <Widget>[
                  <Widget>[
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Working time',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: <Widget>[
                          GestureDetector(
                            child: <Widget>[
                              Obx(() {
                                return Image.asset(
                                  controller.workType.value == 0
                                      ? 'assets/selected.webp'
                                      : 'assets/unselect.webp',
                                  width: 14,
                                  height: 14,
                                );
                              }),
                              const SizedBox(
                                width: 3,
                              ),
                              Obx(() {
                                return Text(
                                  'Morning',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: controller.workType.value == 0
                                          ? primaryColor
                                          : Colors.grey),
                                );
                              })
                            ].toRow(),
                            onTap: () {
                              controller.workType.value = 0;
                              controller.entity?.workType = 0;
                            },
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          GestureDetector(
                            child: <Widget>[
                              Obx(() {
                                return Image.asset(
                                  controller.workType.value == 1
                                      ? 'assets/selected.webp'
                                      : 'assets/unselect.webp',
                                  width: 14,
                                  height: 14,
                                );
                              }),
                              const SizedBox(
                                width: 3,
                              ),
                              Obx(() {
                                return Text(
                                  'Afternoon',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: controller.workType.value == 1
                                          ? primaryColor
                                          : Colors.grey),
                                );
                              })
                            ].toRow(),
                            onTap: () {
                              controller.workType.value = 1;
                              controller.entity?.workType = 1;
                            },
                          )
                        ].toRow(),
                      ),
                    )
                  ].toRow(),
                  Divider(
                    height: 15,
                    indent: 120,
                    color: Colors.grey.withOpacity(0.4),
                  )
                ].toColumn(),
                <Widget>[
                  <Widget>[
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Working hours',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 40,
                      child: RRTextField(
                          padding: EdgeInsets.zero,
                          isInteger: true,
                          maxLength: 5,
                          value: (controller.entity?.workDuring != 0 &&
                                  controller.entity?.workDuring != null)
                              ? controller.entity?.workDuring.toString() ?? ''
                              : '',
                          onChange: (value) {
                            controller.entity?.workDuring =
                                value.isEmpty ? 0 : (int.tryParse(value) ?? 0);
                          }),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Hours',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ].toRow(),
                  Divider(
                    height: 15,
                    indent: 120,
                    color: Colors.grey.withOpacity(0.4),
                  )
                ].toColumn(),
                <Widget>[
                  <Widget>[
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Working payment',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 40,
                      child: RRTextField(
                          padding: EdgeInsets.zero,
                          maxLength: 11,
                          isInteger: true,
                          value: (controller.entity?.price != 0 &&
                                  controller.entity?.price != null)
                              ? controller.entity?.price.toString() ?? ''
                              : '',
                          onChange: (value) {
                            controller.entity?.price =
                                value.isEmpty ? 0 : (int.tryParse(value) ?? 0);
                          }),
                    ))
                  ].toRow(),
                  Divider(
                    height: 15,
                    indent: 120,
                    color: Colors.grey.withOpacity(0.4),
                  )
                ].toColumn(),
                Visibility(
                  visible: !controller.isAdd,
                  child: <Widget>[
                    <Widget>[
                      const SizedBox(
                        width: 100,
                        child: Text(
                          'Working status',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: <Widget>[
                            GestureDetector(
                              child: <Widget>[
                                Obx(() {
                                  return Image.asset(
                                    controller.workStatus.value == 0
                                        ? 'assets/selected.webp'
                                        : 'assets/unselect.webp',
                                    width: 14,
                                    height: 14,
                                  );
                                }),
                                const SizedBox(
                                  width: 3,
                                ),
                                Obx(() {
                                  return Text(
                                    'Doing',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: controller.workStatus.value == 0
                                            ? primaryColor
                                            : Colors.grey),
                                  );
                                })
                              ].toRow(),
                              onTap: () {
                                controller.workStatus.value = 0;
                                controller.entity?.workStatus = 0;
                              },
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            GestureDetector(
                              child: <Widget>[
                                Obx(() {
                                  return Image.asset(
                                    controller.workStatus.value == 1
                                        ? 'assets/selected.webp'
                                        : 'assets/unselect.webp',
                                    width: 14,
                                    height: 14,
                                  );
                                }),
                                const SizedBox(
                                  width: 3,
                                ),
                                Obx(() {
                                  return Text(
                                    'Complete',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: controller.workStatus.value == 1
                                            ? primaryColor
                                            : Colors.grey),
                                  );
                                })
                              ].toRow(),
                              onTap: () {
                                controller.workStatus.value = 1;
                                controller.entity?.workStatus = 1;
                              },
                            )
                          ].toRow(),
                        ),
                      )
                    ].toRow(),
                    Divider(
                      height: 15,
                      indent: 120,
                      color: Colors.grey.withOpacity(0.4),
                    )
                  ].toColumn(),
                )
              ].toColumn(),
            ))
          ].toColumn(),
        );
      }),
    ).decorated(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)));
  }
}
