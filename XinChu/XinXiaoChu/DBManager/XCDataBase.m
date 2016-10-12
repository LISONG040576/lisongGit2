//
//  HSDataBase.m
//  HaierSmart
//
//  Created by WhenWe on 16/5/7.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#define DB_Path_Document [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#import "XCDataBase.h"

static FMDatabase *dbPointer = nil;

@implementation XCDataBase

+ (FMDatabase *)shareDataBase
{
    if (dbPointer == nil) {
        dbPointer = [XCDataBase openDB];
    }else{
        [dbPointer open];
    }
    return dbPointer;
}

+ (FMDatabase *)openDB
{
    NSString *dbPath = [self setUpDB];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:dbPath];
    [db open];
    return db;
}

+ (void)closeDB:(FMDatabase *)db
{
    [db close];
}

+ (NSString *)setReadyDB
{
    NSString *sourcePath = [[NSBundle mainBundle]pathForResource:@"HaierSmart" ofType:@"db"];
    return sourcePath;
}

+ (NSString *)setUpDB
{
    NSString *realPath = [DB_Path_Document stringByAppendingPathComponent:@"HaierSmart.db"];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"HaierSmart" ofType:@"db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    @synchronized ([self class]) {
        if ([fileManager fileExistsAtPath:realPath]) {
            NSDictionary *fileAttri = [fileManager attributesOfItemAtPath:realPath error:nil];
            NSDictionary *sourceAttri = [fileManager attributesOfItemAtPath:sourcePath error:nil];
            
            NSDate *fileDate = [fileAttri objectForKey:@"NSFileCreationDate"];
            NSDate *sourceDate = [sourceAttri objectForKey:@"NSFileCreationDate"];
            
            if ([fileDate compare:sourceDate] < 0) {
                //处理操作时间等
            }
        }else{
            NSError *error = nil;
            if (![fileManager copyItemAtPath:sourcePath toPath:realPath error:&error]) {
                //copy报错
            }
        }
    }
    
    return realPath;
}

+ (void)closeDefault
{
    if (dbPointer) {
        [dbPointer close];
        dbPointer = NULL;
    }
}

@end
