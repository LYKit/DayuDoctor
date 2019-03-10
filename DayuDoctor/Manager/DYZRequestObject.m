//
//  DYZRequestObject.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/7.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "AppDelegate.h"

@implementation DYZRequestObject


- (void)startPostWithSuccessBlock:(LYRequestSuccessBlock)success failBlock:(LYRequestFailBlock)fail {
    
    __weak typeof(self) weakSelf = self;
    [super startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        
        if ([responseObject isKindOfClass:[LYResponseObject class]]) {
            LYResponseObject *response = (LYResponseObject *)responseObject;
            if (response.resultcode.integerValue == 0) {
                success(responseObject, options);
            } else {
                LYNetworkError *customError = [LYErrorConfig networkError:nil rspCode:response.resultcode.integerValue];
                fail(customError, nil);
                [weakSelf showErrorDescription:response.resultmsg];
            }
        } else {
            success(responseObject, options);
        }
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        fail(error,options);
        [weakSelf showErrorDescription:error.description];
    }];
    
}



- (void)showErrorDescription:(NSString *)description {
    UIWindow *window = ((AppDelegate*)([UIApplication sharedApplication].delegate)).window;
    [window makeToast:description];
}

@end
