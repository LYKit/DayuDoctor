//
//  APISearchRecord.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/23.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APISearchRecord.h"

@implementation APISearchRecord


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/search/record");
    }
    return self;
}

@end


@implementation ResponseSearchRecord

@end
