//
//  UIButton+Custom.h
//  基础控件
//
//  Created by z on 16/3/7.
//  Copyright © 2016年 z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)

/**
 *  创建button
 *
 *  @param frame           button的大小
 *  @param title           文本
 *  @param size            字体大小
 *  @param textColor       字体颜色
 *  @param bgColor         button背景颜色
 *  @param backgroundImage button背景图片
 *  @param target
 *  @param selector
 *
 *  @return 
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                          titleFont:(CGFloat)size
                          textColor:(UIColor *)textColor
                    backgroundColor:(UIColor *)bgColor
                    backgroundImage:(UIImage *)backgroundImage
                             target:(id)target
                           selector:(SEL)selector;

@end
