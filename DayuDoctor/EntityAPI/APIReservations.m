//
//  APIReservations.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/18.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "APIReservations.h"

@implementation APIReservations


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interfaceURL = InterfaceURL(@"/orders/user");
    }
    return self;
}


@end



@implementation ResponseReservations
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [Reservations class],
             };
}
@end


@implementation Reservations
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"rid" : @"id"
             };
};
@end
