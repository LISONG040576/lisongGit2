//
//  XCBaseTableViewController.h
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/24.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCBaseTableViewController : UITableViewController


/*******************************************
 
 接入表视图空内容时的展位视图控件，根据需求给以下属性赋值即可，无需自己创建视图，示例可运行项目，观看我的模块效果（需要点击一下）
 
 按钮的点击响应事件，要实现以下协议方法：- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{ // Do something}
 
 *******************************************/
/**
 *  空位图图片
 */
@property(nonatomic,strong)UIImage *emptyImage;
/**
 *  空位视图按钮图片
 */
@property(nonatomic,strong)UIImage *emptyButtonImage;
/**
 *  空位图提示title
 */
@property(nonatomic,strong)NSString *emptyTitleStr;
/**
 *  空位图提示详情信息
 */
@property(nonatomic,strong)NSString *emptyDetailStr;

@end
