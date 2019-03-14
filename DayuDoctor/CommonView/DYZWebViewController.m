//
//  DYZWebViewController.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/5.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZWebViewController.h"
#import "ZFNoramlViewController.h"
#import "PlayerViewController.h"
#import "DYZVipRightsController.h"
#import "DYZClassCourseController.h"

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
    [userController addScriptMessageHandler:self name:@"toMyRights"];
    [userController addScriptMessageHandler:self name:@"toHomeCategory"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"playVideo"]) {
        NSDictionary *params = message.body;
        NSLog(@"%@",params[@"videoId"]);
        
        PlayerViewController *vc = [PlayerViewController new];
        vc.onlineURL = params[@"videoId"];
        vc.playMode = PlayerModeOnline;
        [_fromController.navigationController pushViewController:vc animated:YES];
    }
    
    if ([message.name isEqualToString:@"toMyRights"]) {
        DYZVipRightsController *vc = [DYZVipRightsController new];
        [_fromController.navigationController pushViewController:vc animated:YES];
    }
    
    if ([message.name isEqualToString:@"toHomeCategory"]) {
        DYZClassCourseController *vc = [DYZClassCourseController new];
        [_fromController.navigationController pushViewController:vc animated:YES];
    }
}




- (void)dealloc{
    [self.userController removeScriptMessageHandlerForName:@"playVideo"];
    [self.userController removeScriptMessageHandlerForName:@"toHomeCategory"];
}

@end
