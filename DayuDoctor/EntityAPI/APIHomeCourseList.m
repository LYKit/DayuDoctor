//
//  APIHomeCourseList.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIHomeCourseList.h"

@implementation APIHomeCourseList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/course/index");
    }
    return self;
}


@end

@implementation ResponseHomeCourseList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"coursesList" : [CourseModel class],
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"coursesList" : @"courses"
             };
}

@end


@implementation CourseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"courseId" : @"id"
             };
}

@end

