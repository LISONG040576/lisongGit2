//
//  UIView+Toast.h
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/25.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Toast)

- (void)makeToastOnWindow:(NSString *)message;

- (void)makeToast:(NSString *)message;

@end
