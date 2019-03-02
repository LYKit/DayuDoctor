//
//  UIViewController+DYZWebView.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/2.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "UIViewController+DYZWebView.h"
#import "AXWebViewController.h"

@implementation UIViewController (DYZWebView)

- (void)openWebPageWithUrlString:(NSString *)urlString {
    AXWebViewController *vc = [[AXWebViewController alloc] initWithAddress:urlString];
    vc.hidesBottomBarWhenPushed = YES;
    vc.showsBackgroundLabel = NO;
    vc.showsToolBar = NO;
    vc.navigationType = AXWebViewControllerNavigationBarItem;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
}


- (void)didPressedBack {
    
}



@end
