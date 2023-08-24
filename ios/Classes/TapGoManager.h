//
//  TapGoManager.h
//  tap_go_sdk
//
//  Created by st on 2023/8/17.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface TapGoManager : NSObject

+ (instancetype)shared;

- (void)initWithAppId:(NSString *)appId
               apiKey:(NSString *)apiKey
            publicKey:(NSString *)publicKey
           callBackId:(NSString *)callBackId
              channel:(FlutterMethodChannel *)channel;

- (void)singlePaymentWithMerTradeNo:(NSString*)merTradeNo
                         totalPrice:(NSString *)totalPrice
                             remark:(NSString*)remark;

- (void)recurrentPaymentWithMerTradeNo:(NSString *)merTradeNo
                                remark:(NSString*)remark;

- (void)singleAndRecurrentPaymentWithMerTradeNo:(NSString*)merTradeNo
                                     totalPrice:(NSString *)totalPrice
                                         remark:(NSString*)remark;

- (NSString *) getSdkVersion;

- (void)setSandBoxModeEnable: (BOOL)enable;

@end

NS_ASSUME_NONNULL_END
