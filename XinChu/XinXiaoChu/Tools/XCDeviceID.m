//
//  HSDeviceID.m
//
//
//  Created by Vols on 16/3/17.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "XCDeviceID.h"
#import "XCKeyChain.h"
#import <UIKit/UIKit.h>

static NSString * const KEY_DEVICEID    = @"E4LB47R934.com.haiersmart.neighbourlife";

@implementation XCDeviceID

+ (NSString *)deviceID {

    if ([self readDeviceID] == nil) {
        [self storeDeviceID];
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    
    return [self readDeviceID];
}

+ (NSString *)readDeviceID {

    NSString * uid = [XCKeyChain load:KEY_DEVICEID];

    return uid;
}

+ (void)storeDeviceID{
    NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [XCKeyChain save:KEY_DEVICEID data:UUID];
}

+ (void)deleteDeviceID {
    [XCKeyChain delete:KEY_DEVICEID];
}


@end
