//
//  LYResponseObject.h
//  LY_MoudleNetworking_Example
//
//  Created by 赵学良 on 2018/7/18.
//  Copyright © 2018年 LangeZhao. All rights reserved.
//
#import <Foundation/Foundation.h>


@protocol LYResponseProtocol <NSObject>

@property (nonatomic, strong) NSNumber *resultcode; // 接口码
@property (nonatomic, copy) NSString *resultmsg; // 接口信息
@property (nonatomic, strong) NSDictionary *resultDict; // result 原始数据


@end


@interface LYResponseObject : NSObject

@property (nonatomic, strong) NSNumber *resultcode; // 接口码
@property (nonatomic, copy) NSString *resultmsg; // 接口信息
@property (nonatomic, strong) NSDictionary *resultDict; // result 原始数据


@end
