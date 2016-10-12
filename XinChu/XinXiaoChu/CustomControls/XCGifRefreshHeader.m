//
//  HSGifRefreshHeader.m
//  HaierSmart
//
//  Created by 海尔智能-李松 on 16/6/18.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import "XCGifRefreshHeader.h"
@interface XCGifRefreshHeader ()

@property (nonatomic,strong) NSMutableArray *refreshImages;//刷新动画的图片数组
@property (nonatomic,strong) NSMutableArray *normalImages;//普通状态下的图片数组

@end

@implementation XCGifRefreshHeader

/**
 *  初始化
 *
 */
- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        //刷新状态时的图片组
        [self setImages:self.refreshImages duration:3.0f forState:MJRefreshStateRefreshing];
        //正常状态时的图片组
        [self setImages:self.normalImages forState:MJRefreshStateIdle];
        //下拉状态时的图片组
        [self setImages:self.normalImages forState:MJRefreshStatePulling];
        //即将刷新状态时的图片组
        [self setImages:self.refreshImages forState:(MJRefreshStateWillRefresh)];
        
        //头视图高度
        self.mj_h = 68;
    }
    
    return self;
}

/**
 *  创建自定义 refresh header
 *
 */
+ (XCGifRefreshHeader *)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    
    XCGifRefreshHeader *header = [[XCGifRefreshHeader alloc] init];
    header.refreshingBlock = refreshingBlock;
    //如果不隐藏这个会默认 图片在最左边不是在中间
    header.lastUpdatedTimeLabel.hidden= YES;
    header.stateLabel.hidden = YES;
    return header;
}


+ (XCGifRefreshHeader *)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action{
    
    XCGifRefreshHeader *header = [[XCGifRefreshHeader alloc] init];
    [header setRefreshingTarget:target refreshingAction:action];
    //如果不隐藏这个会默认 图片在最左边不是在中间
    header.lastUpdatedTimeLabel.hidden= YES;
    header.stateLabel.hidden = YES;
    return header;
}

/**
 *  懒加载 正常状态下的图片组
 *
 */
- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"giffood14"]];
        [_normalImages addObject:image];
    }
    return _normalImages;
}
/**
 *  懒加载 刷新状态下的图片组
 */
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [NSMutableArray array];
        //循环添加图片
        for (int i = 1; i<13; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"giffood%d", i]];
            [_refreshImages addObject:image];
        }
    }
    return _refreshImages;
}


- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    
    NSInteger y =  (NSInteger)(self.scrollView.contentOffset.y);
    
    if (-y - self.ignoredScrollViewContentInsetTop < 54) {
        
        [self setImages:@[ImageWithName(@"giffood14")] forState:MJRefreshStatePulling];
        
        //设置缩放比例
        CGFloat scale = (-y - self.ignoredScrollViewContentInsetTop) / 54.0;
        self.gifView.transform = CGAffineTransformMakeScale(scale,scale);
        
    }else{
        
        self.gifView.transform = CGAffineTransformMakeScale(1,1);
        
        [self setImages:@[ImageWithName(@"giffood14")] forState:MJRefreshStatePulling];
    }
}
///** 当scrollView的contentSize发生改变的时候调用 */
//- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的拖拽状态发生改变的时候调用 */
//- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
//    
//    [super scrollViewPanStateDidChange:change];
////    NSLog(@"%@",change);
//}


/**
 *  背景颜色赋值
 */
- (void)setHeaderBgColor:(UIColor *)headerBgColor{
    
    self.backgroundColor = headerBgColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
