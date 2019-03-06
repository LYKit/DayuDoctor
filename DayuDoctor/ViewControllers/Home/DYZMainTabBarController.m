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


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DYZMemberManager aotuLogin];
    });

    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"guideIsShow"]) {
        NSArray *imageNameArray = @[@"guide1.jpg",@"guide2.jpg",@"guide3.jpg",@"guide4.jpg"];
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
        [self.view addSubview:guidePage];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"guideIsShow"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:kLoginSuccesStatus object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:kOutLoginSuccesStatus object:nil];
}

- (void)reloadView {
    UIViewController *fourController = nil;
    if ([DYZMemberManager sharedMemberManger].token.length) {
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
    DYZMineViewController *fourViewController = [[DYZMineViewController alloc] init];
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
                            CYLTabBarItemImage : @"icon_home",
                            CYLTabBarItemSelectedImage : @"icon_home2",
                            };
    NSDictionary *dict2 = @{CYLTabBarItemTitle : @"分类",
                            CYLTabBarItemImage : @"icon_catgory",
                            CYLTabBarItemSelectedImage : @"icon_catgory2",
                            };
    NSDictionary *dict3 = @{CYLTabBarItemTitle : @"报名",
                            CYLTabBarItemImage : @"icon_signup",
                            CYLTabBarItemSelectedImage : @"icon_signup2",
                            };
    NSDictionary *dict4 = @{CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"icon_me",
                            CYLTabBarItemSelectedImage : @"icon_me2",
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
