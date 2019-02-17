//
//  APIUpdateUserInfo.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/16.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIUpdateUserInfo.h"

@implementation APIUpdateUserInfo


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/user/update/detail");
    }
    return self;
}

- (Class)responseName {
    return [ResponseCommon class];
}

@end
