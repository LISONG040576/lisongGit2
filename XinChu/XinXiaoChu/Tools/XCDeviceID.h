//
//  HSDeviceID.h
//  
//
//  Created by Vols on 16/3/17.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCDeviceID : NSObject

/**
 *  获取设备的唯一标示
 */
+ (NSString *)deviceID;


/**
 *  删除设备的唯一标示
 */
+ (void)deleteDeviceID;

@end
