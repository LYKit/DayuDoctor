//
//  APIClassifyAll.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/24.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIClassifyAll.h"

@implementation APIClassifyAll
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/classify/all");
    }
    return self;
}


- (Class)responseName {
    return [ResponseClassify class];
}


@end
