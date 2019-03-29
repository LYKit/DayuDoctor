//
//  NSDictionary+URLCode.m
//  bangjob
//
//  Created by 赵学良 on 2018/12/26.
//  Copyright © 2018年 com.58. All rights reserved.
//

#import "NSDictionary+URLQuery.h"

@implementation NSDictionary (URLQuery)

+ (instancetype)dictionaryWithURLQuery:(NSString *)query {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (query.length && [query rangeOfString:@"="].location != NSNotFound) {
        if ([query rangeOfString:@"?"].location != NSNotFound) {
            NSMutableArray *hostqueryPairs = [[query componentsSeparatedByString:@"?"] mutableCopy];
            NSString *host = hostqueryPairs.firstObject;
            [hostqueryPairs removeFirstObject];
            NSString *query = [hostqueryPairs componentsJoinedByString:@"?"];
            
            NSArray *keyValuePairs = [host componentsSeparatedByString:@"&"];
            for (int i = 0; i < keyValuePairs.count; i++) {
                BOOL last = i == keyValuePairs.count -1;
                NSString *keyValuePair = keyValuePairs[i];
                NSArray *pair = [keyValuePair componentsSeparatedByString:@"="];
                NSString *paramValue = pair.count == 2 ? pair.lastObject : @"";
                parameters[pair.firstObject] = ({
                    if (last) {
                        paramValue = [NSString stringWithFormat:@"%@?%@",paramValue,query];
                    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    [paramValue stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                }) ?: @"";
#pragma clang diagnostic pop
            }
            
        } else {
            NSArray *keyValuePairs = [query componentsSeparatedByString:@"&"];
            for (NSString *keyValuePair in keyValuePairs) {
                NSArray *pair = [keyValuePair componentsSeparatedByString:@"="];
                NSString *paramValue = pair.count == 2 ? pair.lastObject : @"";
                parameters[pair.firstObject] = ({
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    [paramValue stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
                }) ?: @"";
            }
        }
    }
    return parameters;
}

@end
