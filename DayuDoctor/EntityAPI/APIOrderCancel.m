//
//  APIOrderCancel.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/19.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIOrderCancel.h"

@implementation APIOrderCancel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/orders/cancel");
    }
    return self;
}

- (Class)responseName {
    return [ResponseCommon class];
}

+ (NSDictionary *)replacedParamsDictionary {
    return @{@"id" : @"rid"};
}

@end
