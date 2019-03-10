//
//  LYRequestManager.m
//  demo
//
//  Created by liang on 2017/6/6.
//  Copyright © 2017年 LYKit. All rights reserved.
///

#import "LYRequestManager2.h"

@implementation LYRequestManager2

static LYRequestManager2 *_sharedClient;

+ (instancetype)sharedClient
{
    if (!_sharedClient) {
        _sharedClient = [LYRequestManager2 manager];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.securityPolicy.allowInvalidCertificates=YES;
        _sharedClient.securityPolicy.validatesDomainName = NO;
        _sharedClient.requestSerializer.HTTPShouldHandleCookies=YES;
        _sharedClient.requestSerializer.timeoutInterval = 5;
//        [_sharedClient.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                        @"application/xml",
                                                                                        @"text/json",
                                                                                        @"text/javascript",
                                                                                        @"text/html",
                                                                                        @"text/plain"]];
        
    }
    return _sharedClient;
}
@end
