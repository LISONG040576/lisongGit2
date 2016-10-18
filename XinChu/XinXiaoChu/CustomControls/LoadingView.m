//
//  LoadingView.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/10/13.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
        self.layer.shadowPath = shadowPath.CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.5f);
        self.layer.shadowOpacity = 0.5f;
        self.layer.cornerRadius = 2;
        
        /** 设置子视图 **/
        UIImageView *loadImageView =[[UIImageView alloc]  initWithFrame:CGRectMake(10, 7, self.height - 16, self.height - 14)];
        loadImageView.image = ImageWithName(@"jinbiImage");
        [self addSubview:loadImageView];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        animation.toValue = @(2 * M_PI);
        animation.duration = 1.0f;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = NO;
        
        [loadImageView.layer addAnimation:animation forKey:nil];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width - self.height, self.height)];
        textLabel.left = loadImageView.right;
        textLabel.text = @"全力加载中...";
        textLabel.font = Font_MN(14);
        textLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:textLabel];
        
        
        
        /**  **/
        
    }
    return self;
}



@end
