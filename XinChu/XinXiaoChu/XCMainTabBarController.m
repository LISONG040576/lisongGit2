//
//  XCMainTabBarController.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/23.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "XCMainTabBarController.h"

#import "XCCommunityController.h"
#import "XCFoodManageController.h"
#import "XCFoodMenuController.h"
#import "XCPersonCenterController.h"
#import "XCRefrigeratorController.h"


@interface XCMainTabBarController ()

@end

@implementation XCMainTabBarController

/**
 *  单例创建
 *
 *  @return 实例对象
 */
+(XCMainTabBarController *) sharedMainController
{
    static XCMainTabBarController * instancedMainController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instancedMainController = [[XCMainTabBarController alloc] init];
    });
    return instancedMainController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *foodMenuNavigationVC     = [self viewControllerWithTitle:@"菜谱"
                                                                               image:@"tabar10"
                                                                       selectedImage:@"tabar11"
                                                                           className:@"XCFoodMenuController"];
    UINavigationController *communityNavigationVC    = [self viewControllerWithTitle:@"圈圈"
                                                                               image:@"tabar20"
                                                                       selectedImage:@"tabar21"
                                                                           className:@"XCCommunityController"];
    UINavigationController *foodManageNavigationVC   = [self viewControllerWithTitle:@"食材管理"
                                                                               image:@"tabar30"
                                                                       selectedImage:@"tabar31"
                                                                           className:@"XCFoodManageController"];
    UINavigationController *refrigeratorNavigationVC = [self viewControllerWithTitle:@"冰箱控制"
                                                                               image:@"tabar40"
                                                                       selectedImage:@"tabar41"
                                                                           className:@"XCRefrigeratorController"];
    UINavigationController *personCenterNavigationVC = [self viewControllerWithTitle:@"我的"
                                                                               image:@"tabar50"
                                                                       selectedImage:@"tabar51"
                                                                           className:@"XCPersonCenterController"];
    
    NSArray *viewControllers = @[foodMenuNavigationVC,
                                 communityNavigationVC,
                                 foodManageNavigationVC,
                                 refrigeratorNavigationVC,
                                 personCenterNavigationVC];
    self.selectedIndex = 0;
    self.tabBar.tintColor = [UIColor orangeColor];
    
    [self setViewControllers:viewControllers animated:NO];
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.translucent = YES;
}

- (void) pageJump:(int)index{
    self.selectedIndex = index;
}

#pragma mark - private method
/**
 *  工厂创建标签栏子控制器
 */
- (UINavigationController *)viewControllerWithTitle:(NSString *)title
                                              image:(NSString *)imageString
                                      selectedImage:(NSString *)selectedImageString
                                          className:(NSString *)className
{
    Class cls = NSClassFromString(className);
    
    XCBaseViewController *viewController = [[cls alloc] init];
    viewController.title  = title;
    UIImage * normalImage = [[UIImage imageNamed:imageString] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectedImage = [[UIImage imageNamed:selectedImageString] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    return navigationViewController;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
