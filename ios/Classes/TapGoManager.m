//
//  TapGoManager.m
//  tap_go_sdk
//
//  Created by st on 2023/8/17.
//

#import "TapGoManager.h"
#import <tapngosdk/TGSDKPayment.h>
#import <tapngosdk/TGSDKPaymentManager.h>
#import <tapngosdk/TGSDKAppDelegate.h>
#import <TapNGoSDK/TGSDKSettings.h>

#define PAY_CURRENCY @"HKD"

@interface TapGoManager ()<TGSDKPaymentResultDelegate>

@property(nonatomic, copy) NSString * appid;
@property(nonatomic, copy) NSString * apiKey;
@property(nonatomic, copy) NSString * publicKey;
@property(nonatomic, copy) NSString * callBackId;
@property(nonatomic, strong) FlutterMethodChannel * channel;
@property(nonatomic, strong) TGSDKPaymentManager * manager;

@end


@implementation TapGoManager



static TapGoManager *_teacher = nil;

+ (instancetype)shared
 {
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
        _teacher = [[TapGoManager alloc] init];
     });
     return _teacher;
 }

- (void)initWithAppId:(NSString *)appId
               apiKey:(NSString *)apiKey
            publicKey:(NSString *)publicKey
           callBackId:(NSString *)callBackId
              channel:(FlutterMethodChannel *)channel{
    _channel = channel;
    _appid = appId;
    _apiKey = apiKey;
    _publicKey = publicKey;
    _callBackId = callBackId;
    _manager = [[TGSDKPaymentManager alloc] initWithDelegate: self];
}

- (void)singlePaymentWithMerTradeNo:(NSString*)merTradeNo
                            totalPrice:(NSString *)totalPrice
                                remark:(NSString*)remark
{
    TGSDKPayment * payment = [self getPayment];
    [payment setSinglePaymentWithMerTradeNo: merTradeNo
                                 totalPrice: totalPrice
                                   currency: PAY_CURRENCY
                                     remark: remark
                                  notifyUrl: @""];
    [_manager doPayment:payment];
}

- (void)recurrentPaymentWithMerTradeNo:(NSString * )merTradeNo
                                   remark:(NSString * )remark
{
    TGSDKPayment * payment = [self getPayment];
    [payment setRecurrentPaymentWithMerTradeNo: merTradeNo
                                      currency: PAY_CURRENCY
                                        remark: remark];
    [_manager doPayment:payment];
}

- (void)singleAndRecurrentPaymentWithMerTradeNo:(NSString * )merTradeNo
                                        totalPrice:(NSString * )totalPrice
                                            remark:(NSString * )remark
{

    TGSDKPayment * payment = [self getPayment];
    [payment setSingleAndRecurrentPaymentWithMerTradeNo: merTradeNo
                                             totalPrice: totalPrice
                                               currency: PAY_CURRENCY
                                                 remark: remark notifyUrl: @""];
    [_manager doPayment:payment];
}



- (NSString *) getSdkVersion {
    return  [TGSDKSettings getSdkVersion];
    
}


- (void)setSandBoxModeEnable: (BOOL)enable {
    [TGSDKSettings setSandBoxModeEnable: enable];
}


- (TGSDKPayment *) getPayment {
    return [[TGSDKPayment alloc] initWithAppId:_appid apiKey:_apiKey publicKey:_publicKey callBackId:_callBackId];
}


#pragma MARK - TGSDKPaymentResultDelegate
- (void)doPaymentSuccessWithPayResult:(TGSDKPayResult*)payResult {
    NSDictionary * result = @{@"code": payResult.resultCode,
                              @"tradeState": [payResult getStringForTradeStatus:payResult.tradeStatus]};
    [_channel invokeMethod: @"paymentSuccessWithPayResult" arguments: result];
//    NSString *resultStr = @"";
//    resultStr = [resultStr stringByAppendingString:@"Payment success\n"];
//    resultStr = [resultStr stringByAppendingFormat:@"resultCode:%@\n", payResult.resultCode];
//    resultStr = [resultStr stringByAppendingFormat:@"merTradeNo:%@\n", payResult.merTradeNo];
//    resultStr = [resultStr stringByAppendingFormat:@"recurrentToken:%@\n", payResult.recurrentToken];
//    resultStr = [resultStr stringByAppendingFormat:@"msg:%@\n", payResult.message];
//    resultStr = [resultStr stringByAppendingFormat:@"tradeNo:%@\n", payResult.tradeNo];
//    resultStr = [resultStr stringByAppendingFormat:@"tradeState:%@\n", [payResult getStringForTradeStatus:payResult.tradeStatus]];
//    NSLog(@"resultStr=%@", resultStr);
}

- (void)doPaymentFailWithPayResult:(TGSDKPayResult *)payResult {
    
    NSString *resultStr = @"";
    resultStr = [resultStr stringByAppendingString:@"Payment fail\n"];
    resultStr = [resultStr stringByAppendingFormat:@"resultCode:%@\n", payResult.resultCode];
    resultStr = [resultStr stringByAppendingFormat:@"merTradeNo:%@\n", payResult.merTradeNo];
    resultStr = [resultStr stringByAppendingFormat:@"recurrentToken:%@\n", payResult.recurrentToken];
    resultStr = [resultStr stringByAppendingFormat:@"msg:%@\n", payResult.message];
    resultStr = [resultStr stringByAppendingFormat:@"tradeNo:%@\n", payResult.tradeNo];
    resultStr = [resultStr stringByAppendingFormat:@"tradeState:%@\n", [payResult getStringForTradeStatus:payResult.tradeStatus]];
    NSLog(@"resultStr=%@", resultStr);
    NSDictionary * result = @{@"code": payResult.resultCode,
                              @"merTradeNo": payResult.merTradeNo,
                              @"token": payResult.recurrentToken,
                              @"message": payResult.message,
                              @"tradeNo": payResult.tradeNo,
                              @"tradeState": [payResult getStringForTradeStatus:payResult.tradeStatus]};
    [_channel invokeMethod: @"paymentFailWithPayResult" arguments: result];
}

@end
