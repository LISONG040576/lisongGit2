//
//  UIColor+HSCustom.h
//  HairSmart
//
//  Created by Vols on 16/3/1.
//  Copyright © 2016年 HairSmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HSCustom)

+ (UIColor *)tabBarColor;

/**
 *  16进制转为UIColor
 *
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;






/**
 *  font colors
 */
//+ (UIColor *)generalFontWhiteColor;//主调白色 #ff922b
//+ (UIColor *)generalFontOrangeColor;//主调橙色 #ffffff
//+ (UIColor *)generalTitleFontBlackColor;//标题内容 #333333
//+ (UIColor *)generalTitleFontGrayColor;//标题 #636363
//+ (UIColor *)generalSubTitleFontGrayColor;//副标题 #bebebe
//
///**
// *  background colors
// */
//+ (UIColor *)backgroundGrayColorA;//底色A #ffffff
//+ (UIColor *)backgroundGrayColorB;//底色B #f4f4f4
//
///**
// *  seperate colors
// */
//+ (UIColor *)seperateThickLineColor;//粗分割线 #f4f4f4
//+ (UIColor *)seperateThinLineColor;//细分割线 #eeeeee
//
///**
// *  icon and label colors
// */
//+ (UIColor *)generalWarmColor;//暖色 #ff922b
//+ (UIColor *)generalCoolColor;//冷色 #94d24d
//+ (UIColor *)smallIconColor;//小图标 #dddddd
//+ (UIColor *)bigIconColor;//大图标 #e5e5e5


@end
