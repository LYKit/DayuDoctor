//
//  APIUploadImg.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/10.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIUploadImg.h"

@implementation APIUploadImg

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/file/user/image");
    }
    return self;
}

- (Class)responseName {
    return [ResponseCommon class];
}



@end
