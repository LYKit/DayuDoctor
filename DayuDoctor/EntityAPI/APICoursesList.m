//
//  APICoursesList.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "APICoursesList.h"

@implementation APICoursesList
- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.interfaceURL = InterfaceURL(@"/course/user");
    self.headerParams = [@{
                          @"token" : @"C34C178C67E04BD4544484F7C593CE81E0AA90E864ED06F8",
                          } mutableCopy];
    return self;
}
@end


@implementation Course
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
};
@end


@implementation ResponseCoursesList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"content" : [Course class],
             };
}
@end
