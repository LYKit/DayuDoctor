//
//  APIClassify.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIClassify.h"

@implementation APIClassify

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/classify/index");
    }
    return self;
}

@end


@implementation ClassifyModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"classID" : @"id"
             };
}

@end

@implementation ResponseClassify
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"classifies" : [ClassifyModel class],
             };
}

@end
