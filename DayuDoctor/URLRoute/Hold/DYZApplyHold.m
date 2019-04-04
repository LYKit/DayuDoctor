//
//  DYZApplyHold.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/4/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZApplyHold.h"

@implementation DYZApplyHold
- (void)holdWithParameters:(NSDictionary *)parameters
{
    NSDictionary *paramsDict = parameters[kRouteHoldParameter];

    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    [tab setSelectedIndex:2];
}
@end
