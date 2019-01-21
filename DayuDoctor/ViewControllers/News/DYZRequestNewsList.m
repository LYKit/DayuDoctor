//
//  DYZRequestNewsList.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZRequestNewsList.h"

@implementation DYZRequestNewsList
- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.interfaceURL = @"http://39.96.167.96/news/list";
    return self;
}

@end
