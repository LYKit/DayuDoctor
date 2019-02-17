//
//  LYRequestObject.h
//  LY_MoudleNetworking_Example
//
//  Created by 赵学良 on 2018/7/18.
//  Copyright © 2018年 LangeZhao. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "LYInterfaceConfig.h"
#import "LYErrorConfig.h"
#import "ResponseCommon.h"
#import "NSObject+LYJSONEntity.h"
#import "LYJSONEntityElementProtocol.h"
#import "LYRequestMethodProtocol.h"



@interface LYRequestObject : NSObject <LYJSONEntityElementProtocol,LYRequestMethodProtocol>


/**  原有方式  **/
/** 接口地址 **/
@property (copy, nonatomic) NSString *interfaceURL;

/** 接口加密后新方式 **/
@property (nonatomic, copy) NSString *host;

/** 接口加密后新方式 **/
@property (nonatomic, copy) NSString *commandKey;

// 设置header里的属性
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSString *> *headerParams;


/**
 是否缓存
 */
@property (assign, nonatomic) BOOL isCache;


@end
