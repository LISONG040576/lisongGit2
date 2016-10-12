//
//  HSDataBase.h
//  HaierSmart
//
//  Created by WhenWe on 16/5/7.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCDataBase : NSObject

+ (FMDatabase *)shareDataBase;

+ (FMDatabase *)openDB;

+ (void)closeDB:(FMDatabase *)db;

+ (NSString *)setUpDB;

+ (NSString *)setReadyDB;

+ (void)closeDefault;

@end
