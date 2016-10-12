//
//  HSAppInfo.h
//  HaierSmart
//
//  Created by Vols on 16/3/3.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  存储一切与app有关的属性配置
 */
@interface XCAppInfo : NSObject

+ (NSString *)appShortVersion;      //app版本号
+ (NSString *)appVersion;           //app打包号
+ (NSString *)appName;              //app名称
+ (NSString *)appCurrentOSVersion;  //当前iOS版本
+ (NSString *)deviceId;             //设备id

@end
