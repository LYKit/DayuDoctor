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
    self.interfaceURL = @"/course/user";
    return self;
}
@end
