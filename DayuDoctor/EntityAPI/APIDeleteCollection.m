//
//  APIDeleteCollection.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/3/3.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "APIDeleteCollection.h"

@implementation APIDeleteCollection
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/course/follow/cancel");
    }
    return self;
}

- (Class)responseName {
    return [ResponseCommon class];
}
@end


