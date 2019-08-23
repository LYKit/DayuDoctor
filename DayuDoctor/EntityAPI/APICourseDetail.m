//
//  APICourseDetail.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/6/8.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "APICourseDetail.h"

@implementation APICourseDetail
- (instancetype)init {
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/course/detail");
    }
    return self;
}

@end

@implementation CourseDetail

- (NSString *)details {
    if (!_details.length) {
        return @"暂无详情，我们尽快更新哦";
    }
    return _details;
}

@end



@implementation ResponseCourseDetail

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"detail" : [CourseDetail class],
             };
}

@end
