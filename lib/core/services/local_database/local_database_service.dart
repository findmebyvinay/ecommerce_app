import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:ecom_app/core/services/local_database/local_database_table.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocalDatabaseService {
  static final LocalDatabaseService _instance =
      LocalDatabaseService._internal();
  factory LocalDatabaseService() => _instance;
  LocalDatabaseService._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await _initializeDatabase();
      return _db!;
    }
  }

  Future<String> _getDbPath() async {
    try {
      final databaseDirPath = await getDatabasesPath();
      return path.join(databaseDirPath, LocalDatabaseConstants.databaseName);
    } catch (e) {
      log("Error getting database path: $e");
      rethrow;
    }
  }

  Future<Database> _initializeDatabase() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
    try {
      String dbPath = await _getDbPath();
      return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    } catch (e) {
      log("Database initialization error: $e");
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.transaction((txn) async {
        await Future.wait([
          txn.execute(CreateTableQueries.createUsersTable),
          txn.execute(CreateTableQueries.productsTable),

        ]);
      });
      log(" database tables created successfully.");
    } catch (e) {
      log("Error creating chat tables: $e");
      rethrow;
    }
  }

  Future<void> closeDatabase() async {
    try {
      if (_db != null) {
        await _db!.close();
        _db = null;
        log("Database closed successfully.");
      }
    } catch (e) {
      log("Error closing database: $e");
    }
  }

  Future<void> deleteDatabaseFile() async {
    try {
      String dbPath = await _getDbPath();
      await deleteDatabase(dbPath);
      _db = null;
      log("Database deleted successfully.");
    } catch (e) {
      log("Error deleting database: $e");
    }
  }
}
