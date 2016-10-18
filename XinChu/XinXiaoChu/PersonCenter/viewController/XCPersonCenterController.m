//
//  XCPersonCenterController.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/23.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "XCPersonCenterController.h"
#import "XCDBManager.h"
#import "XCDataBase.h"
#import <sqlite3.h>

@interface XCPersonCenterController ()
{
    sqlite3 *db;
}
@property(nonatomic,strong)NSArray *dataList;
@end

@implementation XCPersonCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 设置空白页占位 **/
    self.emptyTitleStr = @"数据出错";
    
    /** 添加数据 **/
    self.dataList = @[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1];
    
    /** 刷新表视图 **/
    [self.tableView reloadData];
    
    
    
    /** 添加背景视图 **/
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, 50)];
    imageV.image = ImageWithName(@"haha");
    [self.view addSubview:imageV];
    
//    /** 设置下拉刷新控件 **/
//    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
//    rc.tintColor = [UIColor whiteColor];
//    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉可以刷新哦～" attributes:@{NSFontAttributeName:Font_MN(10)}];
//    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
//    self.refreshControl = rc;
    
    
    
}

- (void)refreshTableView{
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString: @"正在为您加载..." attributes:@{NSFontAttributeName:Font_MN(10)}];
    }
    dismissHUDWithDelay(2.0, ^{
        [self.tableView.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString: @"下拉可以刷新哦～" attributes:@{NSFontAttributeName:Font_MN(10)}];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellid"];
//        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.dataList = @[];
    [self.tableView reloadData];
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{ // Do something
    
    self.dataList = @[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1];
    
    [self.tableView reloadData];
//    showHUDWithString(@"正在加载...");
    
//    dismissHUDWithDelay(2.0);
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
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
