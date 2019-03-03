//
//  APIMessage.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIMessage.h"

@implementation APIMessage

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/message/user");
    }
    return self;
}


@end


@implementation Message
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"mid" : @"id"
             };
}

@end


@implementation ResponseMessage

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [Message class],
             };
}

@end
