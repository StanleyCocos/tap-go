#import "TapGoSdkPlugin.h"
#import <tapngosdk/TGSDKAppDelegate.h>
#import <tapngosdk/TGSDKPayment.h>
#import "TapGoManager.h"

@interface TapGoSdkPlugin ()

@property(nonatomic, strong) FlutterMethodChannel * channel;

@end


@implementation TapGoSdkPlugin


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"tap_go_sdk"
            binaryMessenger:[registrar messenger]];
  TapGoSdkPlugin* instance = [[TapGoSdkPlugin alloc] init];
    instance.channel = channel;
    [registrar addApplicationDelegate:instance];
  [registrar addMethodCallDelegate:instance channel:channel];
    
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
  if ([@"init" isEqualToString:call.method]) {
      [TapGoManager.shared initWithAppId:call.arguments[@"appId"]
                                   apiKey:call.arguments[@"apiKey"]
                                publicKey:call.arguments[@"publicKey"]
                              callBackId:call.arguments[@"callBackId"]
                                 channel: _channel];
      result(NULL);
  } else if([@"singlePay" isEqualToString:call.method]){
      [TapGoManager.shared singlePaymentWithMerTradeNo:call.arguments[@"merTradeNo"]
                                               totalPrice:call.arguments[@"totalPrice"]
                                                   remark:call.arguments[@"remark"]];
      result(NULL);
      
  } else if([@"recurrentPay" isEqualToString:call.method]){
      [TapGoManager.shared recurrentPaymentWithMerTradeNo:call.arguments[@"merTradeNo"]
                                                      remark:call.arguments[@"remark"]];
      result(NULL);
  } else if([@"singleAndRecurrentPay" isEqualToString:call.method]){
      [TapGoManager.shared singleAndRecurrentPaymentWithMerTradeNo:call.arguments[@"merTradeNo"]
                                                           totalPrice:call.arguments[@"totalPrice"]
                                                               remark:call.arguments[@"remark"]];
      result(NULL);
  }  else if([@"getSdkVersion" isEqualToString:call.method]){
      NSString * version = [TapGoManager.shared getSdkVersion];
      result(version);
  } else if([@"setSandBoxModeEnable" isEqualToString:call.method]){
      [TapGoManager.shared setSandBoxModeEnable: call.arguments[@"enable"]];
      result(NULL);
  } else {
    result(FlutterMethodNotImplemented);
  }
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL * )url {
    [[TGSDKAppDelegate sharedInstance] application:application
                                         handleOpenURL:url];
    return YES;
    
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
options:(NSDictionary<NSString*, id> *)options {
    
    [[TGSDKAppDelegate sharedInstance] application:app handleOpenURL:url];
    return YES;
}


@end
