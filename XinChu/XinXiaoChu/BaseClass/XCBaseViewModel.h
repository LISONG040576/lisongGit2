//
//  XCBaseViewModel.h
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/23.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCBaseViewModel : NSObject

/**
 *  错误信息提示，由RAC监听改属性的变化
 */
@property(nonatomic,strong)NSString *errorString;
/**
 *  网络请求返回数据
 */
@property(nonatomic,assign)BOOL ok;
/**
 *  返回的message
 */
@property(nonatomic,strong)NSString *resultMessage;
/**
 *  返回的code
 */
@property(nonatomic,assign)NSInteger resultCode;

/**
 *  创建需要的RAC命令（一般用来包装网络请求）- 由子类实现
 */
- (void)setupRACCommand;
/**
 *  创建需要的RAC数据信号 － 由子类实现
 */
- (void)setupRACSignal;

@end
