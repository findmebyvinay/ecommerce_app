// ignore_for_file: unused_element, avoid_types_as_parameter_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefsServices {
  final SharedPreferences sharedPreferences;

  SharedPrefsServices(this.sharedPreferences);

  ///FUNC [init] : Initialize shared prefs
  // Future<void> init() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  // }

  ///FUNC [_encodeListToString] : Convert list of object to string
  static String _encodeListToString({required List dynamicList}) =>
      json.encode(dynamicList.map((data) => data.toJson()).toList());

  ///FUNC [_decodeStringToList] : Convert encoded string list to list of generic type
  static dynamic _decodeStringToList({
    required String encodedListToString,
    required Function fromJson,
  }) => (json.decode(encodedListToString) as List<dynamic>)
      .map((item) => fromJson(item))
      .toList();

  ///FUNC [saveDynamicModel] : Save particular object (model) in shared prefs
  Future<void> saveDynamicModel<T>({
    required data, // data is model dat, UserModel data which is need to be stored
    required String key,
  }) async {
    try {
      String dynamicData = json.encode(data.toJson());
      await sharedPreferences.setString(key, dynamicData);
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  ///FUNC [getDynamicModel] : Get particular object (model) from shared prefs
  T? getDynamicModel<T>({
    required dynamic T,
    required String key,
    required Function
    fromJson, // fromJson is model fromJson function which convert jsonModel to model
  }) {
    try {
      Map<String, dynamic> dynamicData = json.decode(
        sharedPreferences.getString(key)!,
      );
      return fromJson(dynamicData);
    } catch (error) {
      return null;
    }
  }

  ///FUNC [saveDynamicList] : Save list of model in shared prefs
  Future<void> saveDynamicList<T>({
    required T,
    required String key,
    required List<T> dynamicList,
  }) async {
    try {
      String encodedData = _encodeListToString(dynamicList: dynamicList);
      await sharedPreferences.setString(key, encodedData);
    } catch (error) {
      rethrow;
    }
  }

  ///FUNC [getDynamicList] : Get list of model from shared prefs [Note: Type Casting is Required]
  List<T> getDynamicList<T>({
    required Type t,
    required String key,
    required Function fromJson,
  }) {
    try {
      String dynamicData = sharedPreferences.getString(key) ?? "";
      return dynamicData.isNotEmpty
          ? (json.decode(dynamicData) as List<dynamic>)
                .map<T>((item) => fromJson(item))
                .toList()
          : [];
    } catch (error) {
      rethrow;
    }
  }

  Future<void> setString({required String key, required String value}) async {
    try {
      await sharedPreferences.setString(key, value);
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  String? getString({required String key}) {
    try {
      return sharedPreferences.getString(key);
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  Future<void> setBool({required String key, required bool value}) async {
    try {
      await sharedPreferences.setBool(key, value);
    } catch (error) {
      rethrow;
    }
  }

  bool? getBool({required String key}) {
    try {
      return sharedPreferences.getBool(key);
    } catch (error) {
      return null;
    }
  }

  Future<void> setInt({required String key, required int value}) async {
    try {
      await sharedPreferences.setInt(key, value);
    } catch (error) {
      rethrow;
    }
  }

  int? getInt({required String key}) {
    try {
      return sharedPreferences.getInt(key);
    } catch (error) {
      return null;
    }
  }

  Future<void> setDouble({required String key, required double value}) async {
    try {
      await sharedPreferences.setDouble(key, value);
    } catch (error) {
      rethrow;
    }
  }

  double? getDouble({required String key}) {
    try {
      return sharedPreferences.getDouble(key);
    } catch (error) {
      return null;
    }
  }

  ///FUNC [removeSharedPrefsData] : Clear shared prefs data
  void removeSharedPrefsData({required String key}) async {
    await sharedPreferences.remove(key);
  }

  ///FUNC [clearSharedPrefsData] : Clear shared prefs data
  void clearSharedPrefsData() async {
    await sharedPreferences.clear();
  }

  void clearOnlyOneData(String key) async {
    await sharedPreferences.remove(key);
  }
}
