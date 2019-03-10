//
//  LYRequestObject.m
//  LY_MoudleNetworking_Example
//
//  Created by 赵学良 on 2018/7/18.
//  Copyright © 2018年 LangeZhao. All rights reserved.
//
#import "LYRequestObject.h"
#import "AFNetworking.h"
#import "LYRequestManager.h"
#import "LYResponseObject.h"
#import "LYParserManager.h"
#import "DYZHTTPHeader.h"


@interface LYRequestObject ()

@property (nonatomic, strong) NSURLSessionDataTask *requestTask;
@property (nonatomic, strong) LYRequestManager *requestManager;


@end


@implementation LYRequestObject

- (void)cancel
{
    [self.requestTask cancel];
}
    
- (void)cancelAllOperation
{
    for (NSURLSessionDataTask *task in self.requestManager.tasks) {
        [task cancel];
    }
    [self.requestManager.operationQueue cancelAllOperations];
}




- (void)startGetWithSuccessBlock:(LYRequestSuccessBlock)success
                       failBlock:(LYRequestFailBlock)fail
{
    [self startGetWithSuccessBlock:success progress:nil failBlock:fail];
}

- (void)startPostWithSuccessBlock:(LYRequestSuccessBlock)success
                       failBlock:(LYRequestFailBlock)fail
{
    [self startPostWithSuccessBlock:success progress:nil failBlock:fail];
}


- (void)startGetWithSuccessBlock:(LYRequestSuccessBlock)success
                        progress:(LYRequestProgressBlock)progress
                       failBlock:(LYRequestFailBlock)fail
{
    [self requestWithSuccessBlock:success progress:progress failBlock:fail method:@"GET"];
}

- (void)startPostWithSuccessBlock:(LYRequestSuccessBlock)success
                        progress:(LYRequestProgressBlock)progress
                       failBlock:(LYRequestFailBlock)fail
{
    [self requestWithSuccessBlock:success progress:progress failBlock:fail method:@"POST"];
}



- (void)requestWithSuccessBlock:(LYRequestSuccessBlock)success
                      progress:(LYRequestProgressBlock)progress
                     failBlock:(LYRequestFailBlock)fail
                         method:(NSString *)method
{
    NSString *responseName = @"";
    if ([self respondsToSelector:@selector(responseName)]) {
        responseName = NSStringFromClass([self responseName]);
    }

#ifdef DEBUG
    if ([self respondsToSelector:@selector(dataSourcePath)]) {
        NSString *path = [self dataSourcePath];
        id object = [LYParserManager dataSourcePath:path classString:NSStringFromClass([self class]) responseName:responseName];
        if (success) {
            success(object,nil);
        }
        return;
    }
#endif
    NSAssert(self.interfaceURL, @"请在 API 接口中设置接口地址");
    
    
    NSDictionary *paramters = [self propertyDictionary];
    NSDictionary *parameterdic = [LYInterfaceConfig addValuesWithParamters:paramters];
    
    self.requestManager = [LYRequestManager sharedClient];
    [self.requestManager configHeaderParams:_headerParams];
    [self.requestManager configHeaderParams:[DYZHTTPHeader commonHeader]];

    self.requestTask = [_requestManager RequestHTTPBody:_interfaceURL method:method parameters:parameterdic progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        responseObject =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
#ifdef DEBUG
        NSLog(@"=============================");
        NSLog(@"接口地址： %@",self.interfaceURL);
        NSLog(@"请求实体类： %@",[self class]);
        NSLog(@"请求参数 : %@",parameterdic);
        NSLog(@"请求成功，返回数据：%@",responseObject);
        NSLog(@"=============================");
#endif
        id object = [LYParserManager objectParserJsonMapPropertyWithClassString:NSStringFromClass([self class]) responseName:responseName data:responseObject];
        if (success) {
            success(object,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
#ifdef DEBUG
        NSLog(@"=============================");
        NSLog(@"接口地址： %@",self.interfaceURL);
        NSLog(@"请求实体类： %@",[self class]);
        NSLog(@"请求参数 : %@",parameterdic);
        NSLog(@"请求失败，错误信息：%@",error.description);
        NSLog(@"=============================");
#endif
        LYNetworkError *lyError = [LYErrorConfig networkError:error rspCode:-1];
        if (fail) {
            fail(lyError,nil);
        }

    }];
    
    if (self.isCache) {
        [self.requestManager.requestSerializer setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    }
}





@end
