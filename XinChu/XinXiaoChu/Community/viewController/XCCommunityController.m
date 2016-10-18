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
#import "LoadingView.h"
#import "PNChart.h"

@interface XCCommunityController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@property WebViewJavascriptBridge *webViewBridge;

@end

@implementation XCCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"圈圈";
    
    /** 单侧圆角测试 **/
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
    
    /** 自定义loading **/
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(100, 100, 150, 40)];
    [self.view addSubview:loadingView];
    
    /** 折线时图测试 **/
    PNCircleChart *circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(50, 350, 100, 100)
                                                                total:@100
                                                              current:@50
                                                            clockwise:YES];
    circleChart.circleBackground.strokeColor = [UIColor grayColor].CGColor;
    [circleChart strokeChart];
    [self.view addSubview:circleChart];
    
    PNCircleChart *circleChart2 = [[PNCircleChart alloc] initWithFrame:CGRectMake(150, 350, 100, 100)
                                                                 total:@100
                                                               current:@50
                                                             clockwise:YES
                                                                shadow:YES
                                                           shadowColor:[UIColor blackColor]];
    [circleChart2 strokeChart];
    [self.view addSubview:circleChart2];
    
    PNCircleChart *circleChart3 = [[PNCircleChart alloc] initWithFrame:CGRectMake(250, 350, 100, 100)
                                                                 total:@100
                                                               current:@50
                                                             clockwise:YES
                                                                shadow:YES
                                                           shadowColor:[UIColor grayColor]
                                                  displayCountingLabel:YES
                                                     overrideLineWidth:@20];
    [circleChart3 strokeChart];
    [self.view addSubview:circleChart3];
    
    
    

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
