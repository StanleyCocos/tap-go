//
//  TapNGoPayment.h
//  tapngosdk
//
//  Created by garychan on 11/4/2016.
//  Copyright © 2016年 com.hktpayment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TGSDKPayment : NSObject

@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *publicKey;
@property (strong, nonatomic) NSString *callBackId;

- (instancetype)initWithAppId:(NSString *)appId
                       apiKey:(NSString *)apiKey
                    publicKey:(NSString *)publicKey
                   callBackId:(NSString *)callBackId;

- (void)setSinglePaymentWithMerTradeNo:(NSString*)merTradeNo
                            totalPrice:(NSString *)totalPrice
                              currency:(NSString*)currency
                                remark:(NSString*)remark
                             notifyUrl:(NSString *)notifyUrl;

- (void)setRecurrentPaymentWithMerTradeNo:(NSString *)merTradeNo
                                 currency:(NSString*)currency
                                   remark:(NSString*)remark;

- (void)setSingleAndRecurrentPaymentWithMerTradeNo:(NSString*)merTradeNo
                                        totalPrice:(NSString *)totalPrice
                                          currency:(NSString*)currency
                                            remark:(NSString*)remark
                                         notifyUrl:(NSString *)notifyUrl;

@end
