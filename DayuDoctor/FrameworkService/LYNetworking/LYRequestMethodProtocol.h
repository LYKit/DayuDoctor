//
//  LYRequestMethodProtocol.h
//  LY_MoudleNetworking_Example
//
//  Created by 赵学良 on 2018/8/10.
//  Copyright © 2018年 LangeZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LYRequestSuccessBlock)(id responseObject, NSDictionary *options);
typedef void(^LYRequestFailBlock)(LYNetworkError *error, NSDictionary *options);
typedef void(^LYRequestProgressBlock)(NSProgress *uploadProgress);


@protocol LYRequestMethodProtocol <NSObject>

/**
 取消当前请求
 */
- (void)cancel;

/**
 取消所有请求
 */
- (void)cancelAllOperation;


/**
 发起请求
 
 @param success 成功回调
 @param fail 失败回调
 */
- (void)startGetWithSuccessBlock:(LYRequestSuccessBlock)success
                       failBlock:(LYRequestFailBlock)fail;

- (void)startPostWithSuccessBlock:(LYRequestSuccessBlock)success
                        failBlock:(LYRequestFailBlock)fail;
/**
 发起请求
 
 @param success 成功回调
 @param progress 进度回调
 @param fail 失败回调
 */
//- (void)startGetWithSuccessBlock:(LYRequestSuccessBlock)success
//                        progress:(LYRequestProgressBlock)progress
//                       failBlock:(LYRequestFailBlock)fail;
//
//- (void)startPostWithSuccessBlock:(LYRequestSuccessBlock)success
//                         progress:(LYRequestProgressBlock)progress
//                        failBlock:(LYRequestFailBlock)fail;



@end
