//
//  UIViewController+DYZWebView.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/2.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "UIViewController+DYZWebView.h"
#import "AXWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "DYZWebViewController.h"

@implementation UIViewController (DYZWebView) 

- (void)openWebPageWithUrlString:(NSString *)urlString {
    NSString *newUrlString = @"";
    NSURL *url = [NSURL URLWithString:urlString];
    if ([DYZMemberManager sharedMemberManger].token.length) {
        if ([urlString containsString:@"token"]) {
            newUrlString = urlString;
        } else if (url.query.length) {
            newUrlString = [NSString stringWithFormat:@"%@&token=%@",urlString,[DYZMemberManager sharedMemberManger].token];
        } else {
            newUrlString = [NSString stringWithFormat:@"%@?token=%@",urlString,[DYZMemberManager sharedMemberManger].token];
        }
    } else {
        newUrlString = urlString;
    }
    
    
    DYZWebViewController *vc = [[DYZWebViewController alloc] initWithWebUrlString:newUrlString];
    vc.fromController = self;
    vc.showsBackgroundLabel = NO;
    vc.showsToolBar = NO;
    vc.navigationType = AXWebViewControllerNavigationBarItem;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
