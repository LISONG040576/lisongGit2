//
//  XCMainTabBarController.h
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/23.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCMainTabBarController : UITabBarController

/**
 *  单例实例化标签栏控制器
 *
 *  @return 返回实例对象
 */
+(XCMainTabBarController *) sharedMainController;

/**
 *  跳转到相应的模块
 *
 */
- (void) pageJump:(int)index;
@end
