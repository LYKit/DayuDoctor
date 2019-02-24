//
//  APIMyCollectionList.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/2/17.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "APIMyCollectionList.h"

@implementation APIMyCollectionList
- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    self.interfaceURL = InterfaceURL(@"/course/follow");
    return self;
}

@end


@implementation CollectionCourse

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
}


@end



@implementation ResponseMyCollectionList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"content" : [CollectionCourse class],
             };
}


@end
