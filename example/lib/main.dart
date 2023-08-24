import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tap_go_sdk/tap_go_sdk.dart';
import 'package:convert/convert.dart' as convert;
import 'package:crypto/crypto.dart' as crypto;

const String AppId = "4265804862";
const String ApiKey =
    "jmaKZmPsZOhkbPpJzzIT5siKhJC4eXiT1phj5W1ZJoSeoUV6JTqFKAuAhCfWwRgamAd21N5EFbe70MFjE1RJeQ==";
const String PublicKey =
    "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAsVdFSIp6+pjaVTURo1vBiGTs/HJAindSQbZKzoVJ7RtzQtNNhWSyk4/ILA6Qn85bQosDj4/Y84Z8aeZUIqcMRfK8lecXQ/ex0VxjJvExA5BD1sC1RQMH/qLV4JGqovS6k25uGz/923FP/P9//0PLT/Hh2567SplxZowmqkl3mPCoi+AUekCMijcY7cWC3GqKpdx+QgK3pY35X97NjtNVBhJWiFDDM29Tm2Apjww/xkQNh78tninFk9zJaS6MtECQW9uOf65tzldkZjkW4zGaeBAE477neQdYF9zf2/cnccL3739Y6KPX3m60e+HT/GsJI7ae7bcYZaMa4HDH3IpCntiS0Dg1CqWE4iFhsPvipvMVQM2+bP5gyrBGD4XsFWGM7Rrugsh4q+qTHy7PmPmVpFQhxGlChtKLdC7Vrc3Z26VAMsAjO1yZfbLZ1ctYJcgfDBMCn8JPm2+r5HXlDjHA+Z31aWQcq+oT8As+QBNWkrhA6nQbO5vTXUFdz2zcL4wiDetiRaFF5TjWdFEPrVDnEQuxdBU0wXLpfippKcKtCIP1t3a91nQvpCgOndNzF/YYg3RN8POr1L7oabanSG7Sh2rEd38MvZ6/ijQufa/i8QenTdtm5fQMb7Ln1csXSaWY3rcE4Z4vdpxIgrbCa2/6HUdb9bu1yXThCbLUa29eMscCAwEAAQ==";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    TapGoSdk.init(
      appId: AppId,
      apiKey: ApiKey,
      publicKey: PublicKey,
      callBackId: AppId,
    );
    TapGoSdk.setSandBoxModeEnable(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () async {
              print("开始支付");
              TapGoSdk.singlePay(
                  merTradeNo: orderID,
                  totalPrice: "0.01",
                  remark: "本次交易未测试1",
                  onSuccess: (result) {
                    // print("成功支付了:: success: $result");
                  },
                  onFail: (result) {
                    print("支付失败：：fail: $result");
                  });
            },
            child: Container(
              width: 100,
              height: 50,
              color: Colors.red,
              child: Text("支付"),
            ),
          ),
        ),
      ),
    );
  }



  String get orderID {
    int number = Random().nextInt(10000000);
    var bytes = const Utf8Encoder().convert('$number');
    var value = crypto.md5.convert(bytes);
    return convert.hex.encode(value.bytes);
  }
}
