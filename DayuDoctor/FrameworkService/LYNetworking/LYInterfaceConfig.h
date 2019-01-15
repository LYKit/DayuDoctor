//
//  LYInterfaceConfig.h
//  LY_MoudleNetworking_Example
//
//  Created by 赵学良 on 2018/7/17.
//  Copyright © 2018年 LangeZhao. All rights reserved.
//
#import <Foundation/Foundation.h>


// IP地址
extern NSString * const HostUrl;


/**
 @param host 地址
 @param interface 接口地址
 @return 完整的请求url
 */
extern NSString *RequestURL (NSString *host,NSString *interface);

/**
 @param path 服务器地址
 @return 完整的请求url， host默认HostUrl
 */
extern NSString *InterfaceURL (NSString *path);


/**
 @param path 服务器地址
 @return 完整的的接口地址 host默认HostUrl
 */
extern NSString *ImageInterfaceURL (NSString *path);


/**
 验证url是否是https: 或者 http:
 @param url 串
 */
extern BOOL SchemeVerify (NSString *url);



@interface LYInterfaceConfig : NSObject


/**
 添加请求参数，可以包括签名处理

 @param dict 原本已有的参数字典
 @return 新参数字典
 */
+ (NSMutableDictionary *)addValuesWithParamters:(NSDictionary *)dict;

@end
