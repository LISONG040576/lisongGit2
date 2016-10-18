//
//  XCRefrigeratorController.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/23.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "XCRefrigeratorController.h"
#import "FangHebaoView.h"

@interface XCRefrigeratorController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation XCRefrigeratorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 创建荷包视图 **/
    FangHebaoView *hebaoView = [[FangHebaoView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_SIZE.width, 100)];
    [self.view addSubview:hebaoView];
    
    /** 创建表视图 **/
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_SIZE.width, kSCREEN_SIZE.height) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
    return cell;
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
