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
// 6F3DD13D94E979E92A0FC4592B971DD82C5C6C98C3B8AB77
@end


@implementation ResponseLogin

@end
