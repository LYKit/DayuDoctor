//
//  APISendCode.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/13.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APISendCode.h"

@implementation APISendCode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/code/send");
    }
    return self;
}

- (Class)responseName {
    return [ResponseCommon class];
}

@end
