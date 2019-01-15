//
//  LYInterfaceConfig.m
//  LY_MoudleNetworking_Example
//
//  Created by 赵学良 on 2018/7/17.
//  Copyright © 2018年 LangeZhao. All rights reserved.
//
#import "LYInterfaceConfig.h"
#import "NSString+Additions.h"

NSString * const HostUrl    = @"";
NSString * const ImgHostUrl = @"";





NSString *InterfaceURL (NSString *path)
{
    if (!path.length)
        return HostUrl;
    return [[HostUrl stringByAppendingString:path] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
};

NSString *ImageInterfaceURL (NSString *path)
{
    if (!path.length)
        return ImgHostUrl;
    return [[ImgHostUrl stringByAppendingString:path] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
};

NSString *RequestURL (NSString *host,NSString *interface)
{
    if (!host.length || !interface.length)
        return @"";
    return [[host stringByAppendingString:interface] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
};


BOOL SchemeVerify (NSString *url)
{
    return ([url containsOfString:@"https://"] || [url containsOfString:@"http://"]);
};



@implementation LYInterfaceConfig

+ (NSMutableDictionary *)addValuesWithParamters:(NSDictionary *)dict
{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict addEntriesFromDictionary:dict];
    
 /* 默认参数及签名规则

 */
    
    return paramDict;
}



@end
