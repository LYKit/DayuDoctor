//
//  APICourseItem.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/6/9.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "APICourseItem.h"

@implementation APICourseItem
- (instancetype)init {
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/course/items");
    }
    return self;
}

@end


@implementation CourseItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
};

@end


@implementation ResponseCourseItem
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"items" : [CourseItem class],
             };
}
@end
