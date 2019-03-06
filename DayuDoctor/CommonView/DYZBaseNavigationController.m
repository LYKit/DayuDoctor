//
//  DYZBaseNavigationController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/6.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZBaseNavigationController.h"

@interface DYZBaseNavigationController ()

@end

@implementation DYZBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
