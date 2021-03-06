//
//  UIView+zy_Frame.h
//  ZYCategory
//
//  Created by ripper on 16/4/30.
//  Copyright © 2016年 ripper. All rights reserved.
//

#import <UIKit/UIKit.h>

#define zy_kScreenW ([UIScreen mainScreen].bounds.size.width)
#define zy_kScreenH ([UIScreen mainScreen].bounds.size.height)

/**
 *  边框类型设置 可多选
 */
typedef NS_OPTIONS(NSUInteger, ZYBorder) {
    ZYBorderLeft   = 1 << 0,
    ZYBorderRight  = 1 << 1,
    ZYBorderTop    = 1 << 2,
    ZYBorderBottom = 1 << 3,
    ZYBorderAll    = ~0UL
};

@interface UIView (zy_Frame)

/** origin、size */
@property CGPoint zy_origin;
@property CGSize zy_size;
/** corner point */
@property (readonly) CGPoint zy_bottomLeft;
@property (readonly) CGPoint zy_bottomRight;
@property (readonly) CGPoint zy_topRight;
/** height... */
@property CGFloat zy_height;
@property CGFloat zy_width;
@property CGFloat zy_x;
@property CGFloat zy_y;
@property CGFloat zy_bottom;
@property CGFloat zy_right;
@property CGFloat zy_centerX;
@property CGFloat zy_centerY;

/** 获取控制器 */
- (UIViewController *)zy_viewController;
/** 根据点移动 */
- (void)moveByPoint:(CGPoint)delta;
/** 放大倍数 */
- (void)magnifyByScale:(CGFloat)scaleFactor;
/** 适配某一个尺寸 */
- (void)fitInSize:(CGSize)size;
/** 利用mask设置圆角 */
- (void)setCornerOnTop:(CGFloat) conner;
- (void)setCornerOnBottom:(CGFloat) conner;
- (void)setCornerOnLeft:(CGFloat) conner;
- (void)setCornerOnRight:(CGFloat) conner;
/** 边框 设置好frame再设置边框 */
- (void)setBorders:(ZYBorder)Borders color:(UIColor*) color width:(CGFloat) width;

@end
