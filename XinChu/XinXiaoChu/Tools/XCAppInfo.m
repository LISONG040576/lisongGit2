//
//  HSAppInfo.m
//  HaierSmart
//
//  Created by Vols on 16/3/3.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import "XCAppInfo.h"

@implementation XCAppInfo

+ (NSString *)appShortVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString *)appName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)versionCode {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"VersionCode"];
}

+ (NSString *)appCurrentOSVersion {
    return [UIDevice currentDevice].systemVersion;
}


+ (NSString *)deviceId
{
    //    return [PAAccount shareInstance].accountContext.deviceId;
    return nil;
}


@end
