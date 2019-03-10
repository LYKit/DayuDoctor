//
//  LYRequestUpload.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/8.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestUpload.h"
#import "LYParserManager.h"
#import "LYRequestManager.h"
#import "DYZHTTPHeader.h"

@interface LYRequestUpload ()
@property (nonatomic, strong) NSURLSessionDataTask *requestTask;
@property (nonatomic, strong) LYRequestManager *requestManager;

@end

@implementation LYRequestUpload

- (void)startUpLoadImgWithSuccessBlock:(LYRequestSuccessBlock)success
                              progress:(LYRequestProgressBlock)progress
                             failBlock:(LYRequestFailBlock)fail
{
    
    NSString *responseName = @"";
    if ([self respondsToSelector:@selector(responseName)]) {
        responseName = NSStringFromClass([self responseName]);
    }
    NSAssert(self.interfaceURL, @"请在 API 接口中设置接口地址");
    
    NSDictionary *paramters = [self propertyDictionary];
    NSDictionary *parameterdic = [LYInterfaceConfig addValuesWithParamters:paramters];
    
    self.requestManager = [LYRequestManager sharedClient];
    [self.requestManager configHeaderParams:self.headerParams];
    [self.requestManager configHeaderParams:[DYZHTTPHeader commonHeader]];

    __weak typeof(self) weakSelf = self;
    self.requestTask = [_requestManager POST:self.interfaceURL parameters:parameterdic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData* imgData = UIImageJPEGRepresentation((UIImage *)weakSelf.uploadImage, 0.3);
        [formData appendPartWithFileData:imgData name:weakSelf.file fileName:weakSelf.fileName mimeType:weakSelf.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
