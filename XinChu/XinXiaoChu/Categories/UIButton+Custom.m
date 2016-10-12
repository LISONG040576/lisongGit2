//
//  UIButton+Custom.m
//  基础控件
//
//  Created by z on 16/3/7.
//  Copyright © 2016年 z. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton (Custom)

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleFont:(CGFloat)size textColor:(UIColor *)textColor backgroundColor:(UIColor *)bgColor backgroundImage:(UIImage *)backgroundImage target:(id)target selector:(SEL)selector{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundColor:bgColor];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

@end
