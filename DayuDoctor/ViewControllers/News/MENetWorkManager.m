//
//  MENetWorkManager.m
//  UIViewExtension
//
//  Created by jinghua on 16/3/12.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "MENetWorkManager.h"
#import "AFNetworking.h"

@implementation MENetWorkManager

+(void)get:(NSString *)url params:(NSDictionary *)params
                          success:(void (^)(id response))success
                         progress:(void (^)(NSProgress * progeress))progress
                          failure:(void (^)(NSError * error))failure {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"text/plain"]];
    
    [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString *)url params:(NSDictionary *)params
                           success:(void (^)(id response))success
                          progress:(void (^)(NSProgress * progeress))progeress
                           failure:(void (^)(NSError * error))failure {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"text/plain",@"application/json", @"text/json", @"text/javascript"]];
    //添加一个默认参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *mobileVersionName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (mobileVersionName.length) {
        [dict setObject:mobileVersionName forKey:@"mobileVersionName"];
    } else {
        [dict setObject:@"获取版本号失败" forKey:@"mobileVersionName"];
    }
    NSString *mobileVersionCode = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if (mobileVersionCode.length) {
        [dict setObject:mobileVersionCode forKey:@"mobileVersionCode"];
    } else {
        [dict setObject:@"获取版本数字失败" forKey:@"mobileVersionCode"];
    }
    
    [dict setObject:@"iOS" forKey:@"mobileConfig"];
    [dict setObject:@"guoxin" forKey:@"mobileBuildFlavor"];
    
    [manager POST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
        NSDictionary *userInfo = error.userInfo;
        NSString *NSDebugDescription = userInfo[@"NSDebugDescription"];
        if ([NSDebugDescription isEqualToString:@"JSON text did not start with array or object and option to allow fragments not set."]) {
            NSLog(@"111111------------登录失效-----------111111");
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id response))success failure:(void(^)(NSError * error))failure {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"text/plain",@"application/json", @"text/json", @"text/javascript"]];
    //添加一个默认参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [dict setObject:@"iOS" forKey:@"mobileConfig"];
    [dict setObject:@"guoxin" forKey:@"mobileBuildFlavor"];
    
    [manager POST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
