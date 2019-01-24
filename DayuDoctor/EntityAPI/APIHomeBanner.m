//
//  APIHomeBanner.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/24.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIHomeBanner.h"

@implementation APIHomeBanner
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/banner");
    }
    return self;
}

@end



@implementation BannerModel


@end


@implementation ResponseHomeBanner

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"banners" : [BannerModel class],
             };
}


@end
