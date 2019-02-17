//
//  APIRegister.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/13.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIRegister.h"

@implementation APIRegister

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/user/add");
    }
    return self;
}

- (Class)responseName {
    return [ResponseCommon class];
}

@end
