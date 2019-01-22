//
//  General.h
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#ifndef General_h
#define General_h


#endif /* General_h */

// iphonex
#import "UIDeviceHardware.h"
#define IS_IPHONE_X ([[UIDeviceHardware platformString] isEqualToString:@"iPhone X"] || SCREEN_SIZE_5)
#define SCREEN_SIZE_5 CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size)


