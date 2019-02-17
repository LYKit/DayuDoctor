//
//  APIFaceTeach.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/14.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIFaceTeach.h"

@implementation APIFaceTeach

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/news/f2f");
    }
    return self;
}

@end



@implementation FaceTeachModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"fid" : @"id"
             };
};


@end


@implementation ResponseFaceTeach
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"content" : [FaceTeachModel class],
             };
}

@end
