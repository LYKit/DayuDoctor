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
#import <JSHAREService.h>
#import <MessageUI/MessageUI.h>

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
    [userController addScriptMessageHandler:self name:@"toLogin"];
    [userController addScriptMessageHandler:self name:@"nativeShare"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"playVideo"]) {
        NSDictionary *params = message.body;
        NSLog(@"%@",params[@"videoId"]);
        
        PlayerViewController *vc = [PlayerViewController new];
        vc.onlineURL = params[@"videoId"];
        vc.videoName = params[@"videoName"];
        vc.playMode = PlayerModeOnline;
        [_fromController.navigationController pushViewController:vc animated:YES];
    } else if ([message.name isEqualToString:@"toMyRights"]) {
        DYZVipRightsController *vc = [DYZVipRightsController new];
        [_fromController.navigationController pushViewController:vc animated:YES];
    } else if ([message.name isEqualToString:@"toHomeCategory"]) {
        DYZClassCourseController *vc = [DYZClassCourseController new];
        [_fromController.navigationController pushViewController:vc animated:YES];
    } else if ([message.name isEqualToString:@"toLogin"]) {
        UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
        [tab setSelectedIndex:3];
    } else if ([message.name isEqualToString:@"nativeShare"]) {
        NSDictionary *params = message.body;
        NSString *url = params[@"url"];
        NSString *type = params[@"type"];
        NSString *title = params[@"title"];
        NSString *content = params[@"content"];
        
        JSHAREPlatform platform = 0;
        if ([type isEqualToString:@"weibo"]) {
            platform = JSHAREPlatformSinaWeibo;
        } else if ([type isEqualToString:@"wechat"]) {
            platform = JSHAREPlatformWechatSession;
        } else if ([type isEqualToString:@"wechatmoments"]) {
            platform = JSHAREPlatformWechatTimeLine;
        } else {
            
        }
        
        [self shareToPlatform:platform
                        title:title
                      content:content
                          url:url];
    }
}

- (void)shareToPlatform:(JSHAREPlatform)platform
                  title:(NSString *)title
                content:(NSString *)content
                    url:(NSString *)url {
    if (   platform == JSHAREPlatformWechatSession
        || platform == JSHAREPlatformWechatTimeLine) {
        if ([JSHAREService isWeChatInstalled] == NO) {
            [self.view makeToast:@"没有安装微信"
                        duration:1
                        position:CSToastPositionCenter];
            return;
        }
    }
    NSString *iconName = [[[[NSBundle mainBundle] infoDictionary]valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage *icon = [UIImage imageNamed:iconName];
    JSHAREMessage *message = [JSHAREMessage message];
    message.title = title;
    message.text = content;
    message.url = url;
    message.platform = platform;
    message.mediaType = JSHARELink;
    message.image = [icon imageDataRepresentation];
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        NSLog(@"分享回调");
        if (!error) {
            [self.view makeToast:@"分享成功"
                        duration:1
                        position:CSToastPositionCenter];
        }
    }];
}



- (void)dealloc{
    [self.userController removeScriptMessageHandlerForName:@"playVideo"];
    [self.userController removeScriptMessageHandlerForName:@"toHomeCategory"];
}

@end
