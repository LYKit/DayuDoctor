//
//  APIFAQS.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/20.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIFAQS.h"

@implementation APIFAQS

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/qanda/list");
    }
    return self;
}

@end


@implementation FAQSModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"qid" : @"id"
             };
}
@end

@implementation ResponseFAQS
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [FAQSModel class],
             };
}
@end
