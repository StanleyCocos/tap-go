//
//  PayResult.h
//  tapngosdk
//
//  Created by garychan on 11/4/2016.
//  Copyright © 2016年 com.hktpayment. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TGSDKPayResultTradeStatusTradeFinished,
    TGSDKPayResultTradeStatusTradeClosed,
    TGSDKPayResultTradeStatusTradeWaitToPay,
    TGSDKPayResultTradeStatusUnknown
} TGSDKPayResultTradeStatus;

@interface TGSDKPayResult : NSObject

@property (strong, nonatomic) NSString* resultCode;
@property (strong, nonatomic) NSString* recurrentToken;
@property (strong, nonatomic) NSString* merTradeNo;
@property (strong, nonatomic) NSString* tradeNo;
@property (assign, nonatomic) TGSDKPayResultTradeStatus tradeStatus;
@property (strong, nonatomic) NSString* message;

- (instancetype)initItemWithURL:(NSURL *)URL;
- (instancetype)initFailResultWithResultCode:(NSString *)resultCode merTradeNo:(NSString *)merTradeNo msg:(NSString *)msg;
- (instancetype)initSdkFailResultWithResultCode:(NSString *)resultCode merTradeNo:(NSString *)merTradeNo;

- (NSString *)getStringForTradeStatus:(TGSDKPayResultTradeStatus)tradeStatus;

- (NSString*) getResultCode;
- (NSString*) getRecurrentToken;
- (NSString*) getMerTradeNo;
- (NSString*) getTradeNo;
- (TGSDKPayResultTradeStatus) getTradeStatus;
- (NSString*) getMessage;

@end
