//
//  HSGifRefreshHeader.h
//  HaierSmart
//
//  Created by 海尔智能-李松 on 16/6/18.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

/**
 *  自定义下拉刷新header控件
 */

#import <MJRefresh/MJRefresh.h>

@interface XCGifRefreshHeader : MJRefreshGifHeader
/**
 *  header背景颜色
 */
@property(nonatomic,strong)UIColor *headerBgColor;


/**
 *  类方法创建refresh header
 *
 *  @param refreshingBlock 刷新时执行的block
 *
 *  @return header 实例
 */
+ (XCGifRefreshHeader *)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

@end
