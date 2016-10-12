//
//  HSHttpRequest.h
//  HaierSmart
//
//  Created by andy on 16/4/8.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCHttpRequest : NSObject

/**
 *  @author andy, 16-04-14 10:04:26
 *
 *  @brief GET方法
 *
 *  @param url     请求地址
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)GET:(NSString *)url
    Success:(void(^)(id result))success
       Fail:(void(^)(NSError *error))fail;

/**
 *  @author andy, 16-04-08 13:04:02
 *
 *  @brief GET方法
 *
 *  @param url     请求地址
 *  @param head    请求头
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)GET:(NSString *)url
       Head:(NSDictionary *)head
    Success:(void(^)(id result))success
       Fail:(void(^)(NSError *error))fail;

/**
 *  @author andy, 16-04-14 10:04:11
 *
 *  @brief POST方法
 *
 *  @param url     请求地址
 *  @param body    请求体
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)POST:(NSString *)url
        Body:(id)body
     Success:(void(^)(id result))success
        Fail:(void(^)(NSError *error))fail;

/**
 *  @author andy, 16-04-08 13:04:57
 *
 *  @brief POST方法
 *
 *  @param url     请求地址
 *  @param head    请求头
 *  @param body    请求体
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)POST:(NSString *)url
        Head:(NSDictionary *)head
        Body:(id)body
     Success:(void(^)(id result))success
        Fail:(void(^)(NSError *error))fail;


/**
 *  监听网络状态
 */
+ (void)observeNetWorkingStatus;




#pragma mark - 链式请求 -
+ (XCHttpRequest *)shareInstance;

- (XCHttpRequest * (^)(BOOL))isGet;

- (XCHttpRequest *(^)(NSString *))url;

- (XCHttpRequest *(^)(NSDictionary *))param;

- (XCHttpRequest *(^)(NSDictionary *))header;

- (void)requestTaskWithSuccess:(void(^)(id result))success fail:(void(^)(NSError *error))fail;

@end
