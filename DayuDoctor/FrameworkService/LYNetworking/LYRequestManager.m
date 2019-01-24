//
//  LYRequestManager.m
//  demo
//
//  Created by liang on 2017/6/6.
//  Copyright © 2017年 LYKit. All rights reserved.
///

#import "LYRequestManager.h"

@implementation LYRequestManager

static LYRequestManager *_sharedClient;

+ (instancetype)sharedClient
{
    if (!_sharedClient) {
        _sharedClient = [LYRequestManager manager];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.securityPolicy.allowInvalidCertificates=YES;
        _sharedClient.securityPolicy.validatesDomainName = NO;
        _sharedClient.requestSerializer.HTTPShouldHandleCookies=YES;
        _sharedClient.requestSerializer.timeoutInterval = 30;
        [_sharedClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [_sharedClient.requestSerializer setValue:@"" forHTTPHeaderField:@"Authentication"];

        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                        @"application/xml",
                                                                                        @"text/json",
                                                                                        @"text/javascript",
                                                                                        @"text/html",
                                                                                        @"text/plain",
                                                                                        @"multipart/form-data"]];

    }
    return _sharedClient;
}

- (void)configHeaderParams:(NSMutableDictionary *)params {
    for (NSString *key in params.allKeys) {
        NSString *value = params[key];
        [self.requestSerializer setValue:value forHTTPHeaderField:key];
    }
}


@end
