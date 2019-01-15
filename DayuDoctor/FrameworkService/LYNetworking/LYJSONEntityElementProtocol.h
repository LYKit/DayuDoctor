//
//  LYJSONEntityElementProtocol.h
//  LY_MoudleNetworking_Example
//
//  Created by 赵学良 on 2018/7/19.
//  Copyright © 2018年 LangeZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LYJSONEntityElementProtocol <NSObject>

@optional
/*  设置JSON和对象属性的映射表(解决接口返回相同对象的问题)
 key:   JSON字段命名
 value: 客户端命名
 */
+ (NSDictionary *)replacedElementDictionary;


/*  设置接口参数和请求实体参数的映射表(解决修改请求参数名的问题)
 key:   接口定义字段命名
 value: 客户端参数命名
 */
+ (NSDictionary *)replacedParamsDictionary;


/**
 自定义Response类
 当请求类和返回类，命名不一致时，或者需要指定返回其他response类，重写此方法指定需要返回的类
 @return 返回自定义Response类名
 */
- (Class)responseName;


/**
 模拟数据的绝对路径， 对应API实现代理生效， 仅debug生效
 */
- (NSString *)dataSourcePath;

@end
