//
//  Utilities.h
//  HaierSmart
//
//  Created by Vols on 16/3/7.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCUtilities : NSObject<UIAlertViewDelegate>

+ (NSString *)emojiWithCode:(int)code;
/**
 *  @author andy, 16-03-18 14:03:07
 *
 *  弹出登录控制器
 *
 *  @param vc 需要弹出登录页面的ViewController
 */
+ (void) showLoginVC:(UIViewController *)vc;

/**
 *  @author andy, 16-04-06 10:04:07
 *
 *  转dic为json
 *
 *  @param 需要转成Str的Dic
 *
 *  @return jsonStr
 */
+ (NSString *) dictionaryToJsonStr:(NSDictionary *)dic;
/**
 *  @author andy, 16-04-06 10:04:33
 *
 *  求 Str的MD5
 *
 *  @param string Str
 *
 *  @return Str的MD5（小写）
 */
+ (NSString *) MD5WithString:(NSString *)string;
/**
 *  @author andy, 16-05-16 19:05:10
 *
 *  @brief 保存用户信息
 *
 *  @param info 用户信息
 */
+ (BOOL) hasLogin;
/**
 *  @author andy, 16-05-09 16:05:33
 *
 *  @brief 获取UserID
 *
 *  @return UserID
 */

+ (void) removeUserInfo;

/**
 *  版本控制
 */
+ (void)versionCheck;

+ (BOOL)hasNewVersionWithNowVersion:(NSString *)nowVersion newVersion:(NSString *)newVersion;




@end
