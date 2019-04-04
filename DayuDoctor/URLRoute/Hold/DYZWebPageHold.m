//
//  DYZWebPageHold.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/4/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZWebPageHold.h"

@implementation DYZWebPageHold

- (void)holdWithParameters:(NSDictionary *)parameters
{
    UIViewController *fromController = parameters[kRouteHoldLastViewController];
    NSDictionary *paramsDict = parameters[kRouteHoldParameter];
    NSString *url = paramsDict[kRouteOriginalURLString];
    [fromController openWebPageWithUrlString:url];
}
@end
