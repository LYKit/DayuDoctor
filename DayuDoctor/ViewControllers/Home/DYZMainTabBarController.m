//
//  DYZMainTabBarController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/1/22.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZMainTabBarController.h"
#import "DYZMainViewController.h"
#import "DYZMineViewController.h"
#import "DYZClassifyController.h"
#import "DYZApplyController.h"

@interface DYZMainTabBarController ()


@end

@implementation DYZMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabBar];
    [self customizeTabBarAppearance];
}

- (void)createTabBar {
    DYZMainViewController *firstViewController = [[DYZMainViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    DYZClassifyController *secondViewController = [[DYZClassifyController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    DYZApplyController *thirdViewController = [[DYZApplyController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:thirdViewController];
    DYZMineViewController *fourViewController = [[DYZMineViewController alloc] init];
    UIViewController *fourNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:fourViewController];
    
    [self customizeTabBarForController];
    [self setViewControllers:@[firstNavigationController,
                               secondNavigationController,
                               thirdNavigationController,
                               fourNavigationController]];
}

- (void)customizeTabBarForController {
    
    NSDictionary *dict1 = @{CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"ico_logo_offline_36",
                            CYLTabBarItemSelectedImage : @"ico_logo_online_36",
                            };
    NSDictionary *dict2 = @{CYLTabBarItemTitle : @"分类",
                            CYLTabBarItemImage : @"ico_rec_nor",
                            CYLTabBarItemSelectedImage : @"ico_rec_pre",
                            };
    NSDictionary *dict3 = @{CYLTabBarItemTitle : @"报名",
                            CYLTabBarItemImage : @"ico_send_nor",
                            CYLTabBarItemSelectedImage : @"ico_send_pre",
                            };
    NSDictionary *dict4 = @{CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"order_btn_gray_nor",
                            CYLTabBarItemSelectedImage : @"order_btn_blue_p",
                            };
    
    NSArray *tabBarItemsAttributes = @[dict1,dict2,dict3,dict4];
    self.tabBarItemsAttributes = tabBarItemsAttributes;
}


- (void)customizeTabBarAppearance {
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#303030"];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#303030"];
    
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


@end
