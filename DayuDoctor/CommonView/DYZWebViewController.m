//
//  DYZWebViewController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/5.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZWebViewController.h"
#import "ZFNoramlViewController.h"

@interface DYZWebViewController () <WKScriptMessageHandler>
@property (nonatomic, strong) WKUserContentController *userController;


@end

@implementation DYZWebViewController


- (instancetype)initWithWebUrlString:(NSString *)urlString {
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    self = [self initWithURL:[NSURL URLWithString:urlString] configuration:configuration];
    if (self) {
        WKUserContentController *userController = [[WKUserContentController alloc] init];
        configuration.userContentController = userController;
        self.userController = userController;
        [self addScriptMessageHandler:userController];
    }
    return self;
}


- (void)addScriptMessageHandler:(WKUserContentController *)userController {
    [userController addScriptMessageHandler:self name:@"playVideo"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"playVideo"]) {
        NSDictionary *params = message.body;
        NSLog(@"%@",params[@"videoId"]);
        
        ZFNoramlViewController *vc = [ZFNoramlViewController new];
        vc.videoId = params[@"videoId"];
        [_fromController.navigationController pushViewController:vc animated:YES];
    }
}




- (void)dealloc{
    [self.userController removeScriptMessageHandlerForName:@"playVideo"];
}

@end
