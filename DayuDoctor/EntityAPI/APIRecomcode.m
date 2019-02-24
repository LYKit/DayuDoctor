//
//  APIRecomcode.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/24.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "APIRecomcode.h"

@implementation APIRecomcode
- (instancetype)init {
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/user/recomcode");
    }
    return self;
}

@end


@implementation ResponseRecomcode

@end
