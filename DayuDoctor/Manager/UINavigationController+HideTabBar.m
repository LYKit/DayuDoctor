//
//  UINavigationController+HideTabBar.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/3.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "UINavigationController+HideTabBar.h"
#import "NSObject+Swizzle.h"

@implementation UINavigationController (HideTabBar)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL orgSel1 = @selector(pushViewController:animated:);
//        SEL newSel1 = @selector(ly_pushViewController:animated:);
//        [self swizzleInstanceSelector:orgSel1 withNewSelector:newSel1];
//
//    });
//}

- (void)ly_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.viewControllers.count > 1) {
        self.hidesBottomBarWhenPushed = YES;
        [self ly_pushViewController:viewController animated:animated];
        self.hidesBottomBarWhenPushed = NO;
//    } else {
//        [self ly_pushViewController:viewController animated:animated];
//    }
}

@end
