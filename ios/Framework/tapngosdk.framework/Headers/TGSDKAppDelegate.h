//
//  TGSDKAppDelegate.h
//  tapngosdk
//
//  Created by garychan on 18/4/2016.
//  Copyright © 2016年 com.hktpayment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TGSDKAppDelegate : NSObject

+ (instancetype)sharedInstance;

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
