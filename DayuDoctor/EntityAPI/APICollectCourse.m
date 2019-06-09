//
//  APICollectCourse.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/6/9.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "APICollectCourse.h"

@implementation APICollectCourse
- (instancetype)init {
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/course/follow/add");
    }
    return self;
}

- (Class)responseName {
    return [ResponseCommon class];
}
@end
