import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:schedule/db_rr/schedule_entity.dart';
import 'package:sqflite/sqflite.dart';

class DBRR extends GetxService {
  late Database dbBase;
  final faker = Faker();

  Future<DBRR> init() async {
    await createScheduleDB();
    return this;
  }

  createScheduleDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'schedule.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createScheduleTable(db);
          await _initData(db);
        });
  }

  createScheduleTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS schedule (id INTEGER PRIMARY KEY, created_time TEXT, image_data BLOB, name TEXT, charge_person TEXT, construction INTEGER, work_type INTEGER, work_during INTEGER, price INTEGER, work_count INTEGER, work_status INTEGER)');
  }

  Future<Uint8List> loadImageBytes(String imagePath) async {
    ByteData data = await rootBundle.load(imagePath);
    Uint8List bytes = data.buffer.asUint8List();
    return bytes;
  }

  _initData(Database db) async {
    for (int i = 0; i < 10; i++) {
      Uint8List bytes = await loadImageBytes('assets/com$i.jpg');
      await db.insert('schedule', {
        'created_time': DateTime.now().toString(),
        'image_data': bytes,
        'name': faker.company.name(),
        'charge_person': '+214 -',
        'construction': faker.randomGenerator.integer(10),
        'work_type': faker.randomGenerator.integer(2),
        'work_during': faker.randomGenerator.integer(4,min: 1),
        'price': faker.randomGenerator.integer(10000),
        'work_status': faker.randomGenerator.integer(2),
      });
    }
  }

  updateSchedule(ScheduleEntity entity) async {
    dbBase.update('schedule', {
      'created_time': entity.createdTime.toIso8601String(),
      'image_data': entity.imageData,
      'name':entity.name,
      'charge_person':entity.chargePerson,
      'construction':entity.construction,
      'work_type':entity.workType,
      'work_during':entity.workDuring,
      'price':entity.price,
      'work_status':entity.workStatus,
    }, where: 'id = ?', whereArgs: [entity.id]);
  }

  deleteSchedule(int id) {
    dbBase.delete('schedule', where: 'id = ?', whereArgs: [id]);
  }

  addSchedule(ScheduleEntity entity) async {
    await dbBase.insert('schedule', {
      'created_time': entity.createdTime.toIso8601String(),
      'image_data': entity.imageData,
      'name':entity.name,
      'charge_person':entity.chargePerson,
      'construction':entity.construction,
      'work_type':entity.workType,
      'work_during':entity.workDuring,
      'price':entity.price,
      'work_status':entity.workStatus,
    });
  }

  void cleanAllData() async {
    await dbBase.delete('schedule');
  }

  Future<List<ScheduleEntity>> getAllData() async {
    var result = await dbBase.query('schedule', orderBy: 'created_time ASC');
    return result.map((e) => ScheduleEntity.fromJson(e)).toList();
  }
}
