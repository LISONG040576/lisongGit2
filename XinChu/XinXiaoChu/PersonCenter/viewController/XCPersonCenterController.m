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
    
    self.emptyTitleStr = @"数据出错";
    
    self.dataList = @[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1];
    
    [self.tableView reloadData];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, kSCREEN_SIZE.height)];
    imageV.image = ImageWithName(@"haha");
    
    self.tableView.backgroundView = imageV;
    
//    NSString *path = [XCDataBase setUpDB];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documents = [paths objectAtIndex:0];
//    NSString *database_path = [documents stringByAppendingPathComponent:@"lisong.sqlite"];
//    
//    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
//        sqlite3_close(db);
//        NSLog(@"数据库打开失败");
//    }
//    
//        NSString *path = [[XCDBManager shareInstance] copyFile2Documents:@"lisong.sqlite"];
    
  
    
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.tintColor = [UIColor whiteColor];
//    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉可以刷新哦～"];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉可以刷新哦～" attributes:@{NSFontAttributeName:Font_MN(10)}];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
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
        cell.backgroundColor = [UIColor clearColor];
    }
    
//    if (indexPath.row % 2 == 0) {
//        cell.backgroundColor = [UIColor blueColor];
//    }else{
//        cell.backgroundColor = [UIColor orangeColor];
//    }
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
