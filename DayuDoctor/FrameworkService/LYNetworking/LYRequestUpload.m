//
//  LYRequestUpload.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/8.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "LYRequestUpload.h"
#import "LYParserManager.h"
#import "LYRequestManager2.h"
#import "DYZHTTPHeader.h"

@interface LYRequestUpload ()
@property (nonatomic, strong) NSURLSessionDataTask *requestTask;
@property (nonatomic, strong) LYRequestManager2 *requestManager;

@end

@implementation LYRequestUpload

- (void)startUpLoadImgWithSuccessBlock:(LYRequestSuccessBlock)success
                              progress:(LYRequestProgressBlock)progress
                             failBlock:(LYRequestFailBlock)fail {
    
    NSDictionary *paramters = [self propertyDictionary];
    NSDictionary *parameterdic = [LYInterfaceConfig addValuesWithParamters:paramters];

    [self.requestManager.requestSerializer setValue:@"token" forHTTPHeaderField:[DYZMemberManager sharedMemberManger].token];

    

    self.requestManager = [LYRequestManager2 sharedClient];
    NSAssert(self.interfaceURL, @"请在 RequestXXX 内中设置接口地址");
    
    
    [self.requestManager POST:self.interfaceURL parameters:parameterdic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString * str  =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
            NSLog(@"%@",str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
//    [self.requestManager POST: self.interfaceURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
////        NSData* imgData = UIImageJPEGRepresentation((UIImage *)self.upIMG, 1.0);
//
////        [formData appendPartWithFileData:imgData name:@"file" fileName:self.fileName mimeType:self.mimeType];
//
////        [formData appendPartWithFileURL:[NSURL URLWithString:@"/Users/zhaoxueliang/Desktop/1.jpg"] name:@"file" fileName:@"" mimeType:self.mimeType error:nil];
//
////        [formData appendPartWithFormData:imgData name:@"file"];
////
////        NSError *error = nil;
////        [formData appendPartWithFileURL:[NSURL URLWithString:@"/Users/zhaoxueliang/Desktop/1.jpg"] name:@"file" error:&error];
////        NSLog(@"%@",error.description);
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            !progress ?: progress(uploadProgress);
//        });
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString * str  =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//
//        NSLog(@"%@",str);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error.description);
//    }];
//
//
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
    
    self.requestManager = [LYRequestManager2 sharedClient];
    
    [self.requestManager.requestSerializer setValue:@"token" forHTTPHeaderField:[DYZMemberManager sharedMemberManger].token];
//    [self.requestManager configHeaderParams:[DYZHTTPHeader commonHeader]];
    
    __weak typeof(self) weakSelf = self;
    self.requestTask = [_requestManager POST:self.interfaceURL parameters:parameterdic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData* imgData = UIImageJPEGRepresentation((UIImage *)weakSelf.upIMG, 1.0);

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    if (self.isCache) {
        [self.requestManager.requestSerializer setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    }
}





@end
