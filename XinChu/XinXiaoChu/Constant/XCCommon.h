//
//  HSCommon.h
//  HairSmart
//
//  Created by Vols on 16/3/1.
//  Copyright © 2016年 HairSmart. All rights reserved.
//  定义相关宏

#ifndef XCCommon_h
#define XCCommon_h

//打印替换
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);

#define USER_ID   [[NSUserDefaults standardUserDefaults] objectForKey:@"USERID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"USERID"] : @""

#define USER_MOBILE   [[NSUserDefaults standardUserDefaults] objectForKey:@"USERMOBILE"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"USERMOBILE"] : @""

//密码
#define PASSWORD  [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"PASSWORD"] :@""

//手机号
#define PHONENUM  [[NSUserDefaults standardUserDefaults] objectForKey:@"PHONENUM"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"PHONENUM"] :@""

//是否激活
#define ACTIVED  [[NSUserDefaults standardUserDefaults] objectForKey:@"actived"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"actived"] :@""
#define REGISTRATIONID   [JPUSHService registrationID] ? [JPUSHService registrationID] :@""


//颜色 -

#define kRGB(r, g, b)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

//16进制字符串 颜色 @"ffffff" 或 @"0xffffff"
#define COLOR_HEX(hexStr)    [UIColor colorWithRed:((strtoul([hexStr UTF8String],0,16)>>16)&0xFF)/255.0f green:((strtoul([hexStr UTF8String],0,16)>>8)&0xFF)/255.0f blue:(strtoul([hexStr UTF8String],0,16)&0xFF)/255.0f alpha:1.0f]
#define COLOR_HEX_ALPHA(hexStr, alphaValue)    [UIColor colorWithRed:((strtoul([hexStr UTF8String],0,16)>>16)&0xFF)/255.0f green:((strtoul([hexStr UTF8String],0,16)>>8)&0xFF)/255.0f blue:(strtoul([hexStr UTF8String],0,16)&0xFF)/255.0f alpha:alphaValue]


//主颜色 - 绿色
#define MAIN_COLOR   COLOR_HEX(@"8bc638")

//宽高获取
#define kSCREEN_SIZE  [UIScreen mainScreen].bounds.size


//字体设置
#define Font(a)     [UIFont fontWithName:@"HelveticaNeue" size:(kSCREEN_SIZE.width == 320 ? a : (kSCREEN_SIZE.width == 375 ? a + 1 : a + 2))]
#define FontBold(a) [UIFont boldSystemFontOfSize:(kSCREEN_SIZE.width == 320 ? a : (kSCREEN_SIZE.width == 375 ? a + 1 : a + 2))]
#define Font_MN(a) [UIFont fontWithName:@"Lao Sangam MN" size:(kSCREEN_SIZE.width == 320 ? a : (kSCREEN_SIZE.width == 375 ? a + 1 : a + 2))]
//图片创建
#define ImageWithName(imageName) [UIImage imageNamed:imageName]


//机型判断 -
#define iPhone4s    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/*按屏幕大小等比缩放 */
#define ScaleFloat(x) x * kSCREEN_SIZE.width / 320

/*类判断*/
#define IS_KIND_DICTIONARY(x) [x isKindOfClass:[NSDictionary class]]
#define IS_KIND_ARRAY(x)      [x isKindOfClass:[NSArray class]]
#define IS_KIND_NUMBER(x)     [x isKindOfClass:[NSNumber class]]
#define IS_KIND_STRING(x)     [x isKindOfClass:[NSString class]]

/*通知宏*/
#define CART_DISPLAY_NOTIFICATION @"display"
#define PAY_RESULT_NOTIFICATION @"payResult"
#define MYFRIDGE_MEMBERS_CHANGE_NOTIFICATION @"FridgeMembersChangeNotification"
#define REFRESH_WIFI_NOTIFICATION @"refreshwi-fi"


#endif /* XCCommon_h */
