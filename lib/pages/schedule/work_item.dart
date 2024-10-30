import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';
import 'package:schedule/db_rr/schedule_entity.dart';
import 'package:schedule/main.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkItem extends StatelessWidget {
  const WorkItem(this.entity, {Key? key}) : super(key: key);

  final ScheduleEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: <Widget>[
        <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(entity.imageData!,
                width: 78, height: 78, fit: BoxFit.cover),
          ).decorated(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12)),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              entity.workStatus == 0 ? entity.price.toString() : 'Complete',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: entity.workStatus == 0
                      ? primaryColor
                      : const Color(0xff8d8d8d)),
            ),
          ).decorated(
              color: entity.workStatus == 0
                  ? primaryColor.withOpacity(0.1)
                  : const Color(0xff8d8d8d).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12))
        ].toColumn(),
        const SizedBox(
          width: 8,
        ),
        Expanded(
            child: <Widget>[
          Text(
            entity.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          <Widget>[
            const Text(
              'Working Hours: ',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              '${entity.workType == 0 ? 'Morning' : 'Afternoon'}-${entity.workDuring}Hours',
              style: const TextStyle(fontSize: 12),
            )
          ].toRow().marginSymmetric(vertical: 5),
          <Widget>[
            const Text(
              'Forecast work duration: ',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              '${entity.construction}Day',
              style: const TextStyle(fontSize: 12),
            )
          ].toRow(),
          Divider(
            height: 25,
            color: Colors.grey.withOpacity(0.4),
          ),
          <Widget>[
            Text(
              'In charge: ${entity.chargePerson}',
              style: TextStyle(fontSize: 12),
            ),
            GestureDetector(
              child: Image.asset(
                'assets/call.webp',
                width: 16,
                height: 16,
              ),
              onTap: () async {
                if (!await launchUrl(Uri.parse('tel:${entity.chargePerson}'))) {
                  Fluttertoast.showToast(msg: 'Unable to make phone calls');
                }
              },
            )
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start))
      ].toRow(crossAxisAlignment: CrossAxisAlignment.start),
    )
        .decorated(color: Colors.white, borderRadius: BorderRadius.circular(10))
        .marginOnly(bottom: 10);
  }
}
