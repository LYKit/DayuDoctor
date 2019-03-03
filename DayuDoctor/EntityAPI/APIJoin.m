//
//  APIJoin.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIJoin.h"

@implementation APIJoin

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/yg/join");
    }
    return self;
}

- (Class)responseName {
    return [ResponseCommon class];
}


@end
