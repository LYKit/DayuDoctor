//
//  APINewsList.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "APINewsList.h"
#import "ResponseCommon.h"

@implementation APINewsList
- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.interfaceURL = InterfaceURL(@"/news/list");
    return self;
}

@end





@implementation News
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
};
@end


@implementation ResponseNewsList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"content" : [News class],
             };
}
@end
