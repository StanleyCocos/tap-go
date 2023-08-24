//
//  TapNGoPaymentResultDelegate.h
//  tapngosdk
//
//  Created by garychan on 11/4/2016.
//  Copyright © 2016年 com.hktpayment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGSDKPayResult.h"

@protocol TGSDKPaymentResultDelegate <NSObject>

@required

/**
 *  Call back protocol for success case
 *
 *  @param payResult Object to store payment result
 */
- (void) doPaymentSuccessWithPayResult:(TGSDKPayResult*)payResult;


/**
 *  Call back protocol for fail case
 *
 *  @param payResult Object to store payment result
 */
- (void) doPaymentFailWithPayResult:(TGSDKPayResult*)payResult;

@end
