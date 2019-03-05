//
//  APIOrderList.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/4.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIOrderList.h"

@implementation APIOrderList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/course/orders");
    }
    return self;
}

@end


@implementation OrderModel

@end

@implementation ResponseOrderList

@end
