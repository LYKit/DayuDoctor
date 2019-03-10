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

@interface LYRequestUpload ()
@property (nonatomic, strong) NSURLSessionDataTask *requestTask;
@property (nonatomic, strong) LYRequestManager *requestManager;

@end

@implementation LYRequestUpload

- (void)startUpLoadImgWithSuccessBlock:(LYRequestSuccessBlock)success
                              progress:(LYRequestProgressBlock)progress
                             failBlock:(LYRequestFailBlock)fail{
    
    NSDictionary *paramters = [self propertyDictionary];
    
    NSDictionary *parameterdic = [LYInterfaceConfig addValuesWithParamters:paramters];
    self.requestManager = [LYRequestManager sharedClient];
    NSAssert(self.interfaceURL, @"请在 RequestXXX 内中设置接口地址");
    [self.requestManager POST: self.interfaceURL parameters:parameterdic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData* imgData = UIImageJPEGRepresentation((UIImage *)self.upIMG, 1.0);
        
        [formData appendPartWithFileData:imgData name:self.file fileName:self.fileName mimeType:self.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !progress ?: progress(uploadProgress);
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });
    }];
    
}



@end
