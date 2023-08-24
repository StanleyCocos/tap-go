import 'tap_go_sdk_platform_interface.dart';

class TapGoSdk {

  static Future<void> init({
    required String appId,
    required String apiKey,
    required String publicKey,
    required String callBackId,
  }) async {
    return await TapGoSdkPlatform.instance.init(
      appId: appId,
      apiKey: apiKey,
      publicKey: publicKey,
      callBackId: callBackId,
    );
  }

  static Future<String> getSdkVersion() async {
    return await TapGoSdkPlatform.instance.getSdkVersion();
  }


  static Future<void> setSandBoxModeEnable(bool enable) async {
    return await TapGoSdkPlatform.instance.setSandBoxModeEnable(enable);
  }

  static Future<void> singlePay({
    String merTradeNo = "",
    String totalPrice = "",
    String remark = "",
    PaymentSuccessWithPayResult? onSuccess,
    PaymentFailWithPayResult? onFail,
  }) async {
    return await TapGoSdkPlatform.instance.singlePay(
      merTradeNo: merTradeNo,
      totalPrice: totalPrice,
      remark: remark,
      onSuccess: onSuccess,
      onFail: onFail,
    );
  }

  static Future<void> recurrentPay({
    String merTradeNo = "",
    String remark = "",
    PaymentSuccessWithPayResult? onSuccess,
    PaymentFailWithPayResult? onFail,
  }) async {
    return await TapGoSdkPlatform.instance.recurrentPay(
      merTradeNo: merTradeNo,
      remark: remark,
      onFail: onFail,
      onSuccess: onSuccess,
    );
  }

 static Future<void> singleAndRecurrentPay({
    String merTradeNo = "",
    String totalPrice = "",
    String remark = "",
    PaymentSuccessWithPayResult? onSuccess,
    PaymentFailWithPayResult? onFail,
  }) async {
    return await TapGoSdkPlatform.instance.singleAndRecurrentPay(
      merTradeNo: merTradeNo,
      totalPrice: totalPrice,
      remark: remark,
      onFail: onFail,
      onSuccess: onSuccess,
    );
  }
}
