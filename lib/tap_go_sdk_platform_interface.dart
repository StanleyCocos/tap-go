import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tap_go_sdk_method_channel.dart';

typedef PaymentSuccessWithPayResult = Function(dynamic);
typedef PaymentFailWithPayResult = Function(dynamic);

abstract class TapGoSdkPlatform extends PlatformInterface {
  /// Constructs a TapGoSdkPlatform.
  TapGoSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static TapGoSdkPlatform _instance = MethodChannelTapGoSdk();

  /// The default instance of [TapGoSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelTapGoSdk].
  static TapGoSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TapGoSdkPlatform] when
  /// they register themselves.
  static set instance(TapGoSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init({
    required String appId,
    required String apiKey,
    required String publicKey,
    required String callBackId,
  }) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> singlePay({
    String merTradeNo = "",
    String totalPrice = "",
    String remark = "",
    PaymentSuccessWithPayResult? onSuccess,
    PaymentFailWithPayResult? onFail,
  }) {
    throw UnimplementedError('singlePayment() has not been implemented.');
  }

  Future<void> recurrentPay({
    String merTradeNo = "",
    String remark = "",
    PaymentSuccessWithPayResult? onSuccess,
    PaymentFailWithPayResult? onFail,
  }) {
    throw UnimplementedError('recurrentPayment() has not been implemented.');
  }

  Future<void> singleAndRecurrentPay({
    String merTradeNo = "",
    String totalPrice = "",
    String remark = "",
    PaymentSuccessWithPayResult? onSuccess,
    PaymentFailWithPayResult? onFail,
  }) {
    throw UnimplementedError(
        'singleAndRecurrentPayment() has not been implemented.');
  }


  Future<String> getSdkVersion(){
    throw UnimplementedError(
        'getSdkVersion() has not been implemented.');
  }


  Future<void> setSandBoxModeEnable(bool enable){
    throw UnimplementedError(
        'setSandBoxModeEnable() has not been implemented.');
  }
}
