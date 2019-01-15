//
//  NSObject+LYJSONEntity.h
//  LY_MoudleNetworking_Example
//
//  Created by 赵学良 on 2018/7/17.
//  Copyright © 2018年 LangeZhao. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LYJSONEntityElementProtocol.h"


@protocol LYJSONEntityPropertyProtocol <NSObject>

@optional
/** 获取到指定父类的属性列表 */
- (Class)ownPropertysUntilClass;

@end



@interface NSObject (LYJSONEntity) <LYJSONEntityElementProtocol, LYJSONEntityPropertyProtocol>

/** 获取当前对象的(属性-值)集合 */
- (NSDictionary *)propertyDictionary;

/** 根据数据集合生成对象 */
+ (id)objectWithDictionary:(NSDictionary *)dictionary;
+ (id)objectWithArray:(NSArray *)array;

/** 获取类属性列表，不包含父类 */
+ (NSArray *)propertyNames;

@end
