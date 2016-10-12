//
//  XCDBManager.h
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/25.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCDBManager : NSObject

+ (instancetype)shareInstance;

-(NSString*)copyFile2Documents:(NSString*)fileName;
@end
