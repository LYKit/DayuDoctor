//
//  LYRequestManager.h
//  demo
//
//  Created by liang on 2017/6/6.
//  Copyright © 2017年 LYKit. All rights reserved.
//

#import "AFHTTPSessionManager.h"

// 前提条件基于AFN
@interface LYRequestManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (void)configHeaderParams:(NSMutableDictionary *)params;

// 请求参数同时添加进 HTTPBody
- (NSURLSessionDataTask *)RequestHTTPBody:(NSString *)URLString
                                   method:(NSString *)method
                            parameters:(NSDictionary *)parameters
                              progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
