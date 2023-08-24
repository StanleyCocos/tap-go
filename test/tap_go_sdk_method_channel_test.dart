import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tap_go_sdk/tap_go_sdk_method_channel.dart';

void main() {
  MethodChannelTapGoSdk platform = MethodChannelTapGoSdk();
  const MethodChannel channel = MethodChannel('tap_go_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
