//
//  APIOrdersDetail.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/19.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIOrdersDetail.h"

@implementation APIOrdersDetail

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/orders/detail");
    }
    return self;
}


+ (NSDictionary *)replacedParamsDictionary {
    return @{@"id" : @"rid"};
}

@end


@implementation OrdersDetail


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"rid" : @"id"
             };
}
@end

@implementation ResponseOrdersDetail
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"detail" : [OrdersDetail class],
             };
}

@end

