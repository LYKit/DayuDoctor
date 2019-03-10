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

        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"application/xml",@"text/json",@"text/javascript",@"text/html", @"text/plain",@"multipart/form-data",@"application/x-www-form-urlencoded",@"image/jpeg", @"image/png"]];

    }
    return _sharedClient;
}

static LYRequestManager *manager = nil;

+ (instancetype)sharedClientNew
{
    if (!manager) {
        manager = [LYRequestManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.securityPolicy.allowInvalidCertificates=YES;
        manager.securityPolicy.validatesDomainName = NO;
        manager.requestSerializer.HTTPShouldHandleCookies=YES;
        manager.requestSerializer.timeoutInterval = 30;
//        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authentication"];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"application/xml",@"text/json",@"text/javascript",@"text/html", @"text/plain"]];
        
    }
    return manager;
}

- (void)configHeaderParams:(NSMutableDictionary *)params {
    for (NSString *key in params.allKeys) {
        NSString *value = params[key];
        [self.requestSerializer setValue:value forHTTPHeaderField:key];
    }
}



- (NSURLSessionDataTask *)RequestHTTPBody:(NSString *)URLString
                                   method:(NSString *)method
                    parameters:(NSDictionary *)parameters
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    
    NSString *json = [parameters jsonStringEncoded];
    NSData *body  =[json dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:body];
    
    if (serializationError) {
        if (failure) {
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}





@end
