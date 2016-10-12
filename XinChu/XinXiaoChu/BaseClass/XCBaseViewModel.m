//
//  XCBaseViewModel.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/23.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "XCBaseViewModel.h"

@implementation XCBaseViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        
        [self setupRACCommand];
        
        [self setupRACSignal];
    }
    return self;
}


/**
 *  创建需要的命令（一般用来包装网络请求）
 */
- (void)setupRACCommand{
    
}

/**
 *  创建需要的数据信号
 */
- (void)setupRACSignal{
    
}

@end
