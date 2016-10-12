//
//  VCyclePicPlayer.h
//  VCyclePicPlayer
//
//  Created by Vols on 15/3/18.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

/**
 *  图片轮播图
 */
#import <UIKit/UIKit.h>

@protocol XCCycleViewDelegate;

@interface XCCycleView : UIView<UIScrollViewDelegate> {

    NSInteger      _totalPages;
    NSInteger      _curPage;
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) UIPageControl *pageControl;
@property (nonatomic,assign) BOOL isAutoPlay;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDelegate:) id<XCCycleViewDelegate> delegate;
@property (nonatomic, assign) CGSize pageControlDotSize; // 分页控件小圆标大小
@property (nonatomic, strong) UIColor *dotColor;         // 分页控件小圆标颜色
@property (nonatomic, strong) NSArray *dataArray;        //设置显示的数据

//初始化数据
- (void)reloadData;

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

//停止，开始
- (void)stopPlay;

- (void)startPlay;

@end

@protocol XCCycleViewDelegate <NSObject>

@optional
/**
 *  页数
 *
 */
- (NSInteger)numberOfPages;

/**
 *  每页的视图
 *
 */
- (UIView *)pageAtIndex:(NSInteger)index;

/**
 *  选中页
 *
 *  @param cyclePicPlayer 对应的轮播图
 *  @param index          选中的下标
 */
- (void)didSelectedCycleView:(XCCycleView *)cycleView atIndex:(NSInteger)index;
@end





