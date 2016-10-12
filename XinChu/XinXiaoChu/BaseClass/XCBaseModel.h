//
//  HSBaseModel.h
//  HaierSmart
//
//  Created by WhenWe on 16/5/3.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

/*************************
 
 该基类自带数据解析方法，一次调用，多层解析，具体应用示例附文件
 
 *******************************/

@interface XCBaseModel : NSObject

/**
 *  可以alloc init后生成model  再set数据
 *
 *  @param dict 数据
 */
- (void)setDict:(NSDictionary *)dict;


/**
 *  也可以直接生成model
 *
 *  @param dict 数据
 */
+ (instancetype )objectWithDict:(NSDictionary *)dict;



// 告诉数组中都是什么类型的模型对象 子类中需要重写;
- (NSDictionary *)objectClassInArray ;

@end

