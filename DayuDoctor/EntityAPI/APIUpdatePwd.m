//
//  APIUpdatePwd.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/13.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIUpdatePwd.h"

@implementation APIUpdatePwd

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/user/update");
    }
    return self;
}

@end


@implementation ResponseUpdatePwd

@end

