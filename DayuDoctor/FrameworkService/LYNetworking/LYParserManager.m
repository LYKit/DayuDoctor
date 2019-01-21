//
//  LYParserManager.m
//  LY_MoudleNetworking_Example
//
//  Created by 赵学良 on 2018/8/10.
//  Copyright © 2018年 LangeZhao. All rights reserved.
//

#import "LYParserManager.h"
//#import "YYModel.h"
#import "LYResponseObject.h"
#import <YYKit.h>

@implementation LYParserManager

+ (id)objectParserJsonMapPropertyWithClassString:(NSString *)clsStr
                                    responseName:(NSString *)responseName
                                            data:(NSDictionary *)data
{
    NSString * responseCls = @"";
    if (responseName.length > 0) {
        responseCls = responseName;
    } else {
        responseCls = [clsStr stringByReplacingOccurrencesOfString:@"API" withString:@"Response"];
    }
    Class cls = NSClassFromString(responseCls);

    NSAssert(cls, @"1、请检查API的接口命名和Response命名是否有误，为确保API的配对性，命名除前缀外需统一命名。2、如果不满足前面命名规则，需实现responseName方法，重新指定Response   3、类是否有实现imp   4、请检查target中是否勾选此类");
    id<LYResponseProtocol> response = [cls modelWithDictionary:data[@"data"]];
    if (!response) {
        response = [cls new];
    }
    if ([response isKindOfClass:[LYResponseObject class]]) {
        response.resultcode = data[@"code"];
        response.resultmsg = data[@"message"];
        response.resultDict = data[@"data"]; // 原始数据
    }
    return response;
}



+ (id)dataSourcePath:(NSString *)path
         classString:(NSString *)clsStr
        responseName:(NSString *)responseName
{
    NSError *err;
    NSDictionary *data;
    
    if ([path hasSuffix:@".txt"]) {
        NSString *dataStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        data = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&err];
    } else if ([path hasSuffix:@".plist"]) {
        data = [NSDictionary dictionaryWithContentsOfFile:path];
    }
     
    
    NSAssert(!err, @"测试数据格式存在问题");
    return [self objectParserJsonMapPropertyWithClassString:clsStr responseName:responseName data:data];
}
@end
