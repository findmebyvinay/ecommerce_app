// ignore_for_file: unused_import, dangling_library_doc_comments

/// CMD TO  Auto Generate "flutter packages pub run build_runner build — delete-conflicting-outputs"

import 'package:ecom_app/core/services/get_it/service_locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
  usesNullSafety: true, // default
)
Future<void> configureDependencies() async => getIt.init();
