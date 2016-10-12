//
//  XCDBManager.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/25.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "XCDBManager.h"

@implementation XCDBManager

+ (instancetype)shareInstance
{
    static XCDBManager *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[XCDBManager alloc]init];
    });
    return manage;
}

-(NSString*)copyFile2Documents:(NSString*)fileName
{
    NSFileManager*fileManager =[NSFileManager defaultManager];
    NSError*error;
    NSString*destPath =[NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    if(![fileManager fileExistsAtPath:destPath]){
        NSString* sourcePath =[[NSBundle mainBundle] pathForResource:@"lisong" ofType:@"sqlite"];
        [fileManager copyItemAtPath:sourcePath toPath:destPath error:&error];
    }
    return destPath;
}
@end
