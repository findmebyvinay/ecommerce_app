import 'package:esewa_flutter_sdk/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel(methoChannelName);

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    
    channel.setMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMethodCallHandler(null);
  });

}
