//
//  UIViewController+DYZBackItem.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/6.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "UIViewController+DYZBackItem.h"
#import "NSObject+Swizzle.h"
#import "AXWebViewController.h"

@implementation UIViewController (DYZBackItem)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL orgSel1 = @selector(viewWillAppear:);
        SEL newSel1 = @selector(dyz_viewWillAppear:);
        [self swizzleInstanceSelector:orgSel1 withNewSelector:newSel1];
        
    });
}

- (void)dyz_viewWillAppear:(BOOL)animation {
    [self dyz_viewWillAppear:animation];
    
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = ({
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
            left.tintColor = [UIColor colorWithHexString:@"666666"];
            left;
        });
    }
}

- (void)dyz_viewWillDisappear:(BOOL)animation {
    [self dyz_viewWillDisappear:animation];
    
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = ({
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
            left.tintColor = [UIColor colorWithHexString:@"666666"];
            left;
        });
    }
}

- (void)backAction {
    if ([self isKindOfClass:[AXWebViewController class]]) {
        WKWebView *webView = ((AXWebViewController *)self).webView;
        if ([webView canGoBack]) {
            [webView goBack];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
