//
//  XCFoodMenuController.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/23.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "XCFoodMenuController.h"

@interface XCFoodMenuController ()
{
    UIView *bgView;
}
@end

@implementation XCFoodMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜谱";
    self.view.backgroundColor = [UIColor orangeColor];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 100)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 20;
   
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64,kSCREEN_SIZE.width, 100)];
    imgView.image = ImageWithName(@"Group2");
    
    bgView.centerY = imgView.centerY;
    [self.view addSubview:bgView];
    [self.view addSubview:imgView];
    
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
        [UIView animateWithDuration:0.5 animations:^{
            bgView.right = ((bgView.left < kSCREEN_SIZE.width / 2.0) ? kSCREEN_SIZE.width :85);
        }];
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
