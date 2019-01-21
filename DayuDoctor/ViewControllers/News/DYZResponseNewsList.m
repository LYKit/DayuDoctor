//
//  DYZResponseNewsList.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/1/20.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZResponseNewsList.h"

@implementation DYZResponseNews

@end

@implementation DYZResponseNewsData
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"content" : [DYZResponseNews class],
             };
}
@end


@implementation DYZResponseNewsList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : [DYZResponseNewsData class]
             };
}
@end
