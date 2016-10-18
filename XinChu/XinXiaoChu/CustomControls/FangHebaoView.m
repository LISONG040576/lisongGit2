//
//  FangHebaoView.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 2016/10/18.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "FangHebaoView.h"
@interface FangHebaoView()

@property(nonatomic,strong)UIImageView *jinBImageView;

@property(nonatomic,strong)UIView      *shadowView;


@end

@implementation FangHebaoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        /** 创建姿势图 **/
        self.jinBImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.jinBImageView.image = ImageWithName(@"jinbiImage");
        [self addSubview:_jinBImageView];
        self.jinBImageView.centerX = self.centerX;
        
        self.shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];
        self.shadowView.backgroundColor = [UIColor grayColor];
        self.shadowView.centerX = self.centerX;
        [self addSubview:_shadowView];
    }
    
    return self;
}

- (void)createSubViews{
    
}

@end
