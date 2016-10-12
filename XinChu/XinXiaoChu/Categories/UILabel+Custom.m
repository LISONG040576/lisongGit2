//
//  UILabel+Custom.m
//  基础控件
//
//  Created by z on 16/3/7.
//  Copyright © 2016年 z. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)
/**
 *  创建UILabel
 *
 *  @param frame     frame
 *  @param text      文本
 *  @param size      字体大小
 *  @param color     字体颜色
 *  @param alignment 对齐方式
 *
 *  @return label
 */
+ (UILabel *)initWithFrame:(CGRect)frame
                      text:(NSString *)text
                      size:(CGFloat)size
                     color:(UIColor *)color
                 alignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setText:text];
    label.font = [UIFont systemFontOfSize:size];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:color];
    [label setTextAlignment:alignment];
    
    return label;
}




@end
