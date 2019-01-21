//
//  DYZRequestCoursesList.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZRequestCoursesList.h"

@implementation DYZRequestCoursesList

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.interfaceURL = @"/course/user";
    return self;
}

@end
