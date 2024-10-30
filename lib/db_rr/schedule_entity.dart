
import 'dart:typed_data';

class ScheduleEntity {

  int id;
  DateTime createdTime;
  Uint8List? imageData;
  String name;
  String chargePerson;
  int construction;
  int workType;
  int workDuring;
  int price;
  int workStatus;

  ScheduleEntity({
    required this.id,
    required this.createdTime,
    this.imageData,
    required this.name,
    required this.chargePerson,
    required this.construction,
    required this.workType,
    required this.workDuring,
    required this.price,
    required this.workStatus,
  });

  factory ScheduleEntity.fromJson(Map<String, dynamic> json) {
    return ScheduleEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['created_time']),
      imageData: json['image_data'],
      name: json['name'],
      chargePerson: json['charge_person'],
      construction: json['construction'],
      workType: json['work_type'],
      workDuring: json['work_during'],
      price: json['price'],
      workStatus: json['work_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_time': createdTime.toIso8601String(),
      'image_data': imageData,
      'name': name,
      'charge_person': chargePerson,
      'construction': construction,
      'work_type': workType,
      'work_during': workDuring,
      'price': price,
      'work_status': workStatus,
    };
  }

}