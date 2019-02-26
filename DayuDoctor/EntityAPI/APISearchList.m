//
//  APISearchList.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/24.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APISearchList.h"

@implementation APISearchList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/course/search");
    }
    return self;
}


@end




@implementation SearchModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sid" : @"id"
             };
}

@end


@implementation ResponseSearchList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"content" : [SearchModel class],
             };
}

@end
