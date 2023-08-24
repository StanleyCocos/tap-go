//
//  TapNGoPaymentManager.h
//  tapngosdk
//
//  Created by garychan on 12/4/2016.
//  Copyright © 2016年 com.hktpayment. All rights reserved.
//
/**
 *  Manager to trigger payment
 *
 */

#import <Foundation/Foundation.h>
#import "TGSDKPaymentResultDelegate.h"
#import "TGSDKPayment.h"

@interface TGSDKPaymentManager : NSObject

@property (strong, nonatomic) id<TGSDKPaymentResultDelegate> delegate;

/**
 *  Initializer
 *
 *  @param delegate Class which implemented TapNGoPaymentResult Delegate
 *
 *  @return TapNGoPaymentManager instance
 */
- (instancetype)initWithDelegate:(id<TGSDKPaymentResultDelegate>)delegate;


/**
 *  Do payment
 *
 *  @param payment Instance of TapNGoPayment
 */
- (void)doPayment:(TGSDKPayment*)payment;

@end
