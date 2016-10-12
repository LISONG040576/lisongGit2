//
//  XCCommunityController.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/23.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "XCCommunityController.h"
#import "UIViewController+XCNumberTypeJudge.h"
#import "WebViewJavascriptBridge.h"
#import "UIView+zy_Frame.h"

@interface XCCommunityController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@property WebViewJavascriptBridge *webViewBridge;

@end

@implementation XCCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"圈圈";
    
   
    UILabel *test1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    test1.centerX = kSCREEN_SIZE.width / 2.0;
    test1.centerY = kSCREEN_SIZE.height / 2.0;
    [test1 setCornerOnLeft:3];
    test1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:test1];
    
    
    
    
    UILabel *test2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    test2.centerX = kSCREEN_SIZE.width / 2.0 + 62;
    test2.centerY = kSCREEN_SIZE.height / 2.0;
    [test2 setCornerOnRight:3];
    test2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:test2];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
