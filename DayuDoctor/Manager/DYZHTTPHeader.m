//
//  DYZHTTPHeader.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/14.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZHTTPHeader.h"
#import "DYZMemberManager.h"

@implementation DYZHTTPHeader

+ (NSDictionary *)commonHeader {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if ([DYZMemberManager sharedMemberManger].token) {
        [params setValue:[DYZMemberManager sharedMemberManger].token forKey:@"token"];
    }
    
    return params;
}

@end
