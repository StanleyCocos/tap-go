import 'package:flutter_test/flutter_test.dart';
import 'package:tap_go_sdk/tap_go_sdk.dart';
import 'package:tap_go_sdk/tap_go_sdk_platform_interface.dart';
import 'package:tap_go_sdk/tap_go_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTapGoSdkPlatform
    with MockPlatformInterfaceMixin
    implements TapGoSdkPlatform {

  @override
  Future<String> getSdkVersion() {
    // TODO: implement getSdkVersion
    throw UnimplementedError();
  }
  
  @override
  Future<void> setSandBoxModeEnable(bool enable) {
    // TODO: implement setSandBoxModeEnable
    throw UnimplementedError();
  }

  @override
  Future<void> init({required String appId, required String apiKey, required String publicKey, required String callBackId}) {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<void> recurrentPay({String merTradeNo = "", String remark = "", PaymentSuccessWithPayResult? onSuccess, PaymentFailWithPayResult? onFail}) {
    // TODO: implement recurrentPay
    throw UnimplementedError();
  }

  @override
  Future<void> singleAndRecurrentPay({String merTradeNo = "", String totalPrice = "", String remark = "", PaymentSuccessWithPayResult? onSuccess, PaymentFailWithPayResult? onFail}) {
    // TODO: implement singleAndRecurrentPay
    throw UnimplementedError();
  }

  @override
  Future<void> singlePay({String merTradeNo = "", String totalPrice = "", String remark = "", PaymentSuccessWithPayResult? onSuccess, PaymentFailWithPayResult? onFail}) {
    // TODO: implement singlePay
    throw UnimplementedError();
  }
}

void main() {
  final TapGoSdkPlatform initialPlatform = TapGoSdkPlatform.instance;

  test('$MethodChannelTapGoSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTapGoSdk>());
  });

  test('getPlatformVersion', () async {
    TapGoSdk tapGoSdkPlugin = TapGoSdk();
    MockTapGoSdkPlatform fakePlatform = MockTapGoSdkPlatform();
    TapGoSdkPlatform.instance = fakePlatform;
  });
}
