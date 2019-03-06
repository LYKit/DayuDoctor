//
//  APICancelOrder.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/5.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APICancelOrder.h"

@implementation APICancelOrder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/course/order/cancel");
    }
    return self;
}

- (Class)responseName {
    return [ResponseCommon class];
}

@end
