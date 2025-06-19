import 'dart:developer';

import 'package:ecom_app/core/constants/typedef.dart';
import 'package:ecom_app/core/services/local_database/local_database_service.dart';
import 'package:sqflite/sqflite.dart';

mixin ResponseDataMixin {
  /// Use this [insertMapData] function for add on new create
  FutureVoid insertMapData(String tableName, Map<String, dynamic> data) async {
    final db = await LocalDatabaseService().database;
    try {
      await db
          .insert(
            tableName,
            data,
            conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
          )
          .then((v) {
            log("Succesfully insert on $tableName: $v");
          });
    } catch (e) {
      log("Insert error on $tableName: $e");
      rethrow;
    }
  }

  /// Use this [updateMapData] function to update or on edit case
  /// use this function while edting the survey
  FutureVoid updateMapData(String tableName, Map<String, dynamic> data) async {
    final db = await LocalDatabaseService().database;
    try {
      await db
          .insert(
            tableName,
            data,
            conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
          )
          .then((v) {
            log("Succesfully update on $tableName: $v");
          });
    } catch (e) {
      log("Insert error on $tableName: $e");
      rethrow;
    }
  }

  /// Use this  [insertMultipleData] function to inseart or add multiple data // list of data
  FutureVoid insertMultipleData(
    String tableName,
    List<Map<String, dynamic>> dataList,
  ) async {
    final db = await LocalDatabaseService().database;
    try {
      Batch batch = db.batch();
      for (var data in dataList) {
        batch.insert(
          tableName,
          data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    } catch (e) {
      log("Bulk insert error on $tableName: $e");
      rethrow;
    }
  }

  // /// Use this FUNC [updateHeaderQuestionData]  to update multiple data of  [[LocalDatabaseTable.headerQuestionResponse]]
  // /// use this function while edting the survey
  // FutureVoid updateHeaderQuestionData(
  //   List<Map<String, dynamic>> dataList,
  // ) async {
  //   final db = await LocalDatabaseService().database;
  //   try {
  //     Batch batch = db.batch();
  //     for (var data in dataList) {
  //       final String? id = data['id'];
  //       final String? parentId = data['parent_id'];
  //       final int? surveyId = data['survey_id'];
  //       batch.update(
  //         LocalDatabaseTable.headerQuestionResponse,
  //         data,
  //         where: 'id = ? AND parent_id = ? AND survey_id = ?',
  //         whereArgs: [id, parentId, surveyId],
  //         conflictAlgorithm: ConflictAlgorithm.replace,
  //       );
  //     }
  //     await batch.commit(noResult: true);
  //   } catch (e) {
  //     log(
  //       "Bulk insert error on ${LocalDatabaseTable.headerQuestionResponse}: $e",
  //     );
  //     rethrow;
  //   }
  // }

  // /// Use this FUNC [updateChildQuestionData]  to update multiple data of  [[LocalDatabaseTable.childQuestionResponse]]
  // /// use this function while edting the survey
  // FutureVoid updateChildQuestionData(
  //   List<Map<String, dynamic>> dataList,
  // ) async {
  //   final db = await LocalDatabaseService().database;
  //   try {
  //     Batch batch = db.batch();
  //     for (var data in dataList) {
  //       final String? id = data['id'];
  //       final String? parentId = data['parent_id'];
  //       final String? childId = data['child_id'];
  //       final int? surveyId = data['survey_id'];
  //       batch.update(
  //         LocalDatabaseTable.childQuestionResponse,
  //         data,
  //         where: 'id = ? AND parent_id = ? AND child_id = ? AND survey_id = ?',
  //         whereArgs: [id, parentId, childId, surveyId],
  //         conflictAlgorithm: ConflictAlgorithm.replace,
  //       );
  //     }
  //     await batch.commit(noResult: true);
  //   } catch (e) {
  //     log(
  //       "Bulk insert error on ${LocalDatabaseTable.childQuestionResponse}: $e",
  //     );
  //     rethrow;
  //   }
  // }
}
