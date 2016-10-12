//
//  AppDelegate.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/22.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*创建window*/
    [self setupWindow];
    
    /*设置键盘监听*/
    [self setupKeyboardObsever];
    
    /*程序异常捕获监听*/
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    
    
    return YES;
}

/**
 *  创建window
 */
- (void)setupWindow{
    // 创建window
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 创建tabbarVC
    XCMainTabBarController *mainTabBarVC = [XCMainTabBarController sharedMainController];
    // 设置根视图控制器
    _window.rootViewController = mainTabBarVC;
    _window.backgroundColor = [UIColor whiteColor];
    // 显示
    [_window makeKeyAndVisible];
}

/**
 *  设置键盘监听
 */
- (void)setupKeyboardObsever{
    //监听键盘自动上移
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

/**
 *  UncaughtExceptionHandler是一个函数指针，该函数需要我们实现，可以取自己想要的名字。当程序发生异常崩溃时，该函数会得到调用
 *
 */
void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];      //非常重要，就是崩溃的原因
    NSString *name = [exception name];          //异常类型
    
    NSLog(@"\n\n***************************--\n exception type : %@ \n crash reason : %@ \n call stack info : %@ \n--**************************\n", name, reason, arr);
    
    //给开发者发送邮件
    NSString *crashLogInfo = [NSString stringWithFormat:@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr];
    NSString *urlStr = [NSString stringWithFormat:@"mailto:lisong@smart-haier.com?subject=bug报告&body=发送此邮件，有助于我们更好的完善应用，感谢您的配合!\n\n\n\n\n错误详情:\n--%@",crashLogInfo];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}



















- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
