import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tap_go_sdk_platform_interface.dart';

/// An implementation of [TapGoSdkPlatform] that uses method channels.
class MethodChannelTapGoSdk extends TapGoSdkPlatform {
  final MethodChannel _channel = const MethodChannel('tap_go_sdk');

  PaymentSuccessWithPayResult? _onSuccess;
  PaymentFailWithPayResult? _onFail;

  MethodChannelTapGoSdk() {
    _channel.setMethodCallHandler(_onMethodCall);
  }

  @override
  Future<void> init({
    required String appId,
    required String apiKey,
    required String publicKey,
    required String callBackId,
  }) async {
    return await _channel.invokeMethod(
      'init',
      {
        "appId": appId,
        'apiKey': apiKey,
        'publicKey': publicKey,
        'callBackId': callBackId,
      },
    );
  }

  @override
  Future<void> singlePay({
    String merTradeNo = "",
    String totalPrice = "",
    String remark = "",
    PaymentSuccessWithPayResult? onSuccess,
    PaymentFailWithPayResult? onFail,
  }) async {
    _onSuccess = onSuccess;
    _onFail = onFail;
    return await _channel.invokeMethod(
      'singlePay',
      {
        "merTradeNo": merTradeNo,
        'totalPrice': totalPrice,
        'remark': remark,
      },
    );
  }


  @override
  Future<void> recurrentPay({
    String merTradeNo = "",
    String remark = "",
    PaymentSuccessWithPayResult? onSuccess,
    PaymentFailWithPayResult? onFail,
  }) async {
    _onSuccess = onSuccess;
    _onFail = onFail;
    return await _channel.invokeMethod(
      'recurrentPay',
      {
        "merTradeNo": merTradeNo,
        'remark': remark,
      },
    );
  }

  @override
  Future<void> singleAndRecurrentPay({
    String merTradeNo = "",
    String totalPrice = "",
    String remark = "",
    PaymentSuccessWithPayResult? onSuccess,
    PaymentFailWithPayResult? onFail,
  }) async {
    _onSuccess = onSuccess;
    _onFail = onFail;
    return await _channel.invokeMethod(
      'singleAndRecurrentPay',
      {
        "merTradeNo": merTradeNo,
        'totalPrice': totalPrice,
        'remark': remark,
      },
    );
  }

  @override
  Future<String> getSdkVersion() async {
    return await _channel.invokeMethod('getSdkVersion');
  }

  @override
  Future<void> setSandBoxModeEnable(bool enable) async {
    return await _channel.invokeMethod('setSandBoxModeEnable', {
      "enable": enable,
    });
  }

  Future<dynamic> _onMethodCall(MethodCall call) async {
    switch (call.method) {
      case "paymentSuccessWithPayResult":
        _onSuccess?.call(call.arguments);
        return;
      case "paymentFailWithPayResult":
        _onFail?.call(call.arguments);
        return;
    }
    throw MissingPluginException(
      '${call.method} was invoked but has no handler',
    );
  }
}
