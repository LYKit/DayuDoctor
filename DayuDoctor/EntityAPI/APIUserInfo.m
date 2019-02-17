//
//  APIUserInfo.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/15.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIUserInfo.h"

@implementation APIUserInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/user/detail");
    }
    return self;
}

@end




@implementation UserInfo

@end


@implementation ResponseUserInfo
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"detail" : [UserInfo class],
             };
}
@end
