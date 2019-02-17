//
//  APILogin.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/13.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APILogin.h"

@implementation APILogin

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/user/login");
    }
    return self;
}

@end


@implementation ResponseLogin

@end
