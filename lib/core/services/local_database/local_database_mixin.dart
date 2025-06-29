import 'dart:developer';

import 'package:ecom_app/core/constants/typedef.dart';
import 'package:ecom_app/core/services/local_database/local_database_service.dart';
import 'package:ecom_app/core/services/local_database/local_database_table.dart';
import 'package:ecom_app/features/cart_page/domain/model/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';

mixin LocalDatabaseOperationsMixin {
  FutureVoid insertMapData(String tableName, Map<String, dynamic> data) async {
    final db = await LocalDatabaseService().database;
    try {
      await db.insert(
        tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
      );
    } catch (e) {
      log("Insert error on $tableName: $e");
      rethrow;
    }
  }

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
  Future<void> insertCartItem(CartItemModel item)async{
    final db = await LocalDatabaseService().database;
    try{
      await db.insert(LocalDatabaseTable.cartItems,{
        'id':item.id,
        'title':item.title,
        'thumbnail':item.thumbnail,
        'price':item.price,
        'category':item.category,
        'quantity':item.quantity,
        'stock':item.stock,
      },
      conflictAlgorithm: ConflictAlgorithm.replace 
      );
      log('${item.id}${item.title}${item.quantity}');
      log('Succesfully added CartItem');
    }
    catch(e){
      log('insert CartItem data failed:$e');
      rethrow;
    }
  }

  Future<void> updateCartItem(CartItemModel item)async{
    final db= await LocalDatabaseService().database;
    try{
      await db.update(LocalDatabaseTable.cartItems,
       {
        'title':item.title,
        'thumbnail':item.thumbnail,
        'price':item.price,
        'category':item.category,
        'quantity':item.quantity,
        'stock':item.stock,
       },
       where: 'id=?',
       whereArgs: [item.id],
       );
       log('updated Cart with id :${item.title}');
    }
    catch(e){
      log('Failed to update cartItems:$e');
      rethrow;
    }
  }

  Future<void> deleteCartItems(String id)async{
    final db = await LocalDatabaseService().database;
    try{
        await db.delete(LocalDatabaseTable.cartItems,
        where: 'id=?',
        whereArgs: [id]);
        log('deleted cart from database:$id');
    }
    catch(e){
      log('Failed to Delete the CartItem:$e');
      rethrow;
    }
  }
  Future<void> clearCart()async{
    final db = await LocalDatabaseService().database;
    await db.delete(LocalDatabaseTable.cartItems);
  }

  Future<List<CartItemModel>> getCartItems()async{
    final db = await LocalDatabaseService().database;
    final result = await db.query(LocalDatabaseTable.cartItems);
    log('Fecthed cart Items:$result');
    return result.map((map)=> CartItemModel(
      id: map['id'] as String,
      title: map['title'] as String,
      thumbnail: map['thumbnail']as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      stock: map['stock']as int,
      )).toList();
      
      
  }
  FutureListMap getAllData(String tableName) async {
    final db = await LocalDatabaseService().database;
    try {
      return await db.query(tableName);
    } catch (e) {
      log("Get data error on $tableName: $e");
      rethrow;
    }
  }

  FutureMap getMapDataById(
    String tableName,
    String columnName,
    dynamic columnValue,
  ) async {
    final db = await LocalDatabaseService().database;
    try {
      final result = await db.query(
        tableName,
        where: '$columnName = ?',
        whereArgs: [columnValue],
        limit: 1,
      );
      if (result.isNotEmpty) {
        return result.first;
      }
      return {};
    } catch (e) {
      log("Get by ID error on $tableName: $e");
      rethrow;
    }
  }

  FutureListMap getListDataById(
    String tableName,
    String columnName,
    dynamic columnValue,
  ) async {
    final db = await LocalDatabaseService().database;
    try {
      final List<Map<String, dynamic>> results = await db.query(
        tableName,
        where: '$columnName = ?',
        whereArgs: [columnValue],
      );
      return results;
    } catch (e) {
      log("Query error on $tableName by $columnName: $e");
      rethrow;
    }
  }

  Future<void> clearTable(String tableName) async {
    final db = await LocalDatabaseService().database;

    try {
      await db.delete(tableName); // Clear all rows
      log('Cleared and reset $tableName');
    } catch (e) {
      log('Error clearing $tableName: $e');
      rethrow;
    }
  }

  Future<void> logAllTableSchemas() async {
    final db = await LocalDatabaseService().database;

    try {
      // Query the schema info from sqlite_master where type='table'
      final List<Map<String, dynamic>> tables = await db.rawQuery(
        "SELECT name, sql FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
      );

      for (final table in tables) {
        final tableName = table['name'];
        final tableSql = table['sql'];
        log('Table: $tableName');
        log('Schema: $tableSql');
      }
    } catch (e) {
      log('Error fetching table schemas: $e');
    }
  }
}
