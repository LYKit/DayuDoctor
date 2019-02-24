//
//  APICourseClassify.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "APICourseClassify.h"

@implementation APICourseClassify
- (instancetype)init {
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/course/classify");
    }
    return self;
}

@end

@implementation ClassifyCourse
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"cid" : @"id"
             };
}
@end

@implementation ResponseCourseClassify
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"content" : [ClassifyCourse class],
             };
}
@end
