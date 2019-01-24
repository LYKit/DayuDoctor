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

#define ADJUST_SCROLLVIEW_INSET_NEVER(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

// 屏幕size
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
