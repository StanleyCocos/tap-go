//
//  TGSDKSettings.h
//  tapngosdk
//
//  Created by garychan on 8/7/2016.
//  Copyright © 2016年 com.hktpayment. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGSDKSettings : NSObject

+ (BOOL)isSandBoxModeEnabled;

+ (void)setSandBoxModeEnable:(BOOL)enable;

+ (NSString*)getSdkVersion;

@end
