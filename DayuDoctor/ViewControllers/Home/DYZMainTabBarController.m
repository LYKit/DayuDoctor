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
#import "DHGuidePageHUD.h"
#import "DYZLoginController.h"
#import "DYZBaseNavigationController.h"


@interface DYZMainTabBarController ()


@end

@implementation DYZMainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBar];
    [self customizeTabBarAppearance];

    [DYZMemberManager aotuLogin];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"guideIsShow"]) {
        NSArray *imageNameArray = @[@"guide-1",@"guide-2",@"guide-3",@"guide-4"];
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
        [self.view addSubview:guidePage];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"guideIsShow"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:kLoginSuccesStatus object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:kOutLoginSuccesStatus object:nil];
}

- (void)reloadView {
    UIViewController *fourController = nil;
    if ([DYZMemberManager isLogin]) {
        fourController = [[DYZMineViewController alloc] init];
    } else {
        fourController = [[DYZLoginController alloc] init];
    }
    DYZBaseNavigationController *fourVC = (DYZBaseNavigationController *)self.viewControllers[3];
    fourVC.viewControllers = @[fourController];
}



- (void)createTabBar {
    DYZMainViewController *firstViewController = [[DYZMainViewController alloc] init];
    UIViewController *firstNavigationController = [[DYZBaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    DYZClassifyController *secondViewController = [[DYZClassifyController alloc] init];
    UIViewController *secondNavigationController = [[DYZBaseNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    DYZApplyController *thirdViewController = [[DYZApplyController alloc] init];
    UIViewController *thirdNavigationController = [[DYZBaseNavigationController alloc]
                                                    initWithRootViewController:thirdViewController];
    
    UIViewController *fourNavigationController = nil;
    DYZLoginController *fourViewController = [[DYZLoginController alloc] init];
    fourNavigationController = [[DYZBaseNavigationController alloc]
                                initWithRootViewController:fourViewController];

    [self customizeTabBarForController];
    [self setViewControllers:@[firstNavigationController,
                               secondNavigationController,
                               thirdNavigationController,
                               fourNavigationController]];
}

- (void)customizeTabBarForController {
    
    NSDictionary *dict1 = @{CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"33",
                            CYLTabBarItemSelectedImage : @"3",
                            };
    NSDictionary *dict2 = @{CYLTabBarItemTitle : @"分类",
                            CYLTabBarItemImage : @"22",
                            CYLTabBarItemSelectedImage : @"2",
                            };
    NSDictionary *dict3 = @{CYLTabBarItemTitle : @"报名",
                            CYLTabBarItemImage : @"44",
                            CYLTabBarItemSelectedImage : @"4",
                            };
    NSDictionary *dict4 = @{CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"11",
                            CYLTabBarItemSelectedImage : @"1",
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
