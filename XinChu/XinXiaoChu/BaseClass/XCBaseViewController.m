//
//  XCBaseViewController.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/23.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "XCBaseViewController.h"

@interface XCBaseViewController ()


@end

@implementation XCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 配置HUD信息 */
    [self configSVProgressHUD];
}

/**
 *  配置HUD信息
 */
- (void)configSVProgressHUD{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        
    /* 监听错误信息 */
    if (self.baseViewModel) {
        [[RACObserve(self.baseViewModel, errorString) skip:1] subscribeNext:^(NSString *errorStr) {
            [SVProgressHUD showErrorWithStatus:errorStr];
        }];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    dismissHUD();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




extern void pushViewController(UIViewController *VC,UIViewController *sencondVC){
    [VC.navigationController pushViewController:sencondVC animated:YES];
}
extern void presentViewController(UIViewController *VC,UIViewController *sencondVC){
    [VC presentViewController:sencondVC animated:YES completion:nil];
}
extern void showHUD(){
    [SVProgressHUD show];
}
extern void showHUDWithString(NSString *string){
    [SVProgressHUD showWithStatus:string];
}

extern void showHUDWithSuccessString(NSString *string){
    [SVProgressHUD showSuccessWithStatus:string];
}

extern void showHUDWithErrorString(NSString *string){
    [SVProgressHUD showErrorWithStatus:string];
}

extern void showHUDWithInfoString(NSString *string){
    [SVProgressHUD showInfoWithStatus:string];
}

extern void showHUDWithProgressAndString(CGFloat progress, NSString *string){
    [SVProgressHUD showProgress:progress status:string];
}

extern void showHUDWithImageAndString(UIImage *image ,NSString *string){
    [SVProgressHUD showImage:image status:string];
}

extern void dismissHUD(){
    [SVProgressHUD dismiss];
}

extern void dismissHUDWithDelay(NSTimeInterval timeInterval,void(^Block)()){
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        Block();
        
    });
}

extern void showHUDWithOnlyText(UIViewController *VC, NSString *textStr){
    [VC.view makeToast:textStr];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void) getVariableWithClass:(Class) myClass varName:(NSString *)name{
//    unsigned int outCount, i;
//    Ivar *ivars = class_copyIvarList(myClass, &outCount);
//    for (i = 0; i < outCount; i++) {
//        Ivar property = ivars[i];
//        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
//        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
//        
//        if ([keyName isEqualToString:name]) {
//            
//            
//            
//        }
//    }
//    
//}


@end
