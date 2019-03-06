//
//  APISearchClear.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/6.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APISearchClear.h"

@implementation APISearchClear

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/search/clear");
    }
    return self;
}

- (Class)responseName {
    return [ResponseCommon class];
}


@end
