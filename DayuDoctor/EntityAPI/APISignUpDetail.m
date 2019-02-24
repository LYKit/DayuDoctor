//
//  APISignUpDetail.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/19.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APISignUpDetail.h"

@implementation APISignUpDetail

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/user/signupdetail");
    }
    return self;
}


@end


@implementation SignUpDetail

@end

@implementation ResponseSignUpDetail
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"detail" : [SignUpDetail class],
             };
}
@end
