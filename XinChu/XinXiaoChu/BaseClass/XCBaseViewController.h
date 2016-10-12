//
//  XCBaseViewController.h
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/23.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Toast.h"


@interface XCBaseViewController : UIViewController

/**
 *  viewModel基类属性，baseVC的每一个子类在初始化子viewmodel 的时候，一定要按照下面的形势编写：
 *  
 *  例子 ： self.baseViewModel = self.子viewModel = [[子ViewModelClass alloc] init];
 */
@property(nonatomic,strong)XCBaseViewModel *baseViewModel;



/**
 *  全局方法集，直接调用
 *
 */

/* pushAction */
extern void pushViewController(UIViewController *VC,UIViewController *sencondVC);
/* presentAction */
extern void presentViewController(UIViewController *VC,UIViewController *sencondVC);
/* 展示HUD ，无文本*/
extern void showHUD();
/* 展示HUD，带文本 */
extern void showHUDWithString(NSString *string);
/* 展示HUD，只有文本 */
extern void showHUDWithOnlyText(UIViewController *VC, NSString *textStr);
/* 展示成功状态HUD */
extern void showHUDWithSuccessString(NSString *string);
/* 展示失败状态HUD */
extern void showHUDWithErrorString(NSString *string);
/* 展示提示文本HUD，（感叹号） */
extern void showHUDWithInfoString(NSString *string);
/* 展示加载进度HUD，带文本 */
extern void showHUDWithProgressAndString(CGFloat progress, NSString *string);
/* 展示自定义图片HUD，带文本 */
extern void showHUDWithImageAndString(UIImage *image ,NSString *string);
/* 隐藏HUD */
extern void dismissHUD();

extern void dismissHUDWithDelay(NSTimeInterval timeInterval,void(^Block)());



@end
