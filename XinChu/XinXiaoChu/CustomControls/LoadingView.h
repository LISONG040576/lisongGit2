//
//  LoadingView.h
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/10/13.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

// 加载图片
@property(nonatomic,strong)UIImage *loadingImage;

// 提示文字
@property(nonatomic,strong)NSString *loadingText;

@end
