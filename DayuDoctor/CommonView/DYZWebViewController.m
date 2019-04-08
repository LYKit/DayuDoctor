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
#import <AlipaySDK/AlipaySDK.h>
#import <JSHAREService.h>
#import <MessageUI/MessageUI.h>

@interface DYZWebViewController () <WKScriptMessageHandler,AXWebViewControllerDelegate>
@property (nonatomic, strong) WKUserContentController *userController;
@property (nonatomic, strong) NSString *detailUrl;

@end

@implementation DYZWebViewController


- (instancetype)initWithWebUrlString:(NSString *)urlString {
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    self = [self initWithURL:[NSURL URLWithString:urlString] configuration:configuration];
    if (self) {
        WKUserContentController *userController = [[WKUserContentController alloc] init];
        configuration.userContentController = userController;
        self.userController = userController;
        self.delegate = self;
        self.enabledWebViewUIDelegate = YES;
        [self addScriptMessageHandler:userController];
        
        // 缓存
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
    _detailUrl = urlString;
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
        UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
        [tab setSelectedIndex:1];
        [_fromController.navigationController popToRootViewControllerAnimated:NO];
    } else if ([message.name isEqualToString:@"toLogin"]) {
        UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
        [tab setSelectedIndex:3];
        [_fromController.navigationController popToRootViewControllerAnimated:NO];
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

- (BOOL)p_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //新版本的H5拦截支付对老版本的获取订单串和订单支付接口进行合并，推荐使用该接口
    __weak typeof(self) weakSelf = self;
    BOOL isIntercepted = [[AlipaySDK defaultService] payInterceptorWithUrl:[request.URL absoluteString] fromScheme:@"dayudoctor" callback:^(NSDictionary *result) {
        // 处理支付结果
        NSLog(@"%@", result);
        // isProcessUrlPay 代表 支付宝已经处理该URL
        if ([result[@"isProcessUrlPay"] boolValue]) {
            // returnUrl 代表 第三方App需要跳转的成功页URL
            NSString* urlStr = result[@"returnUrl"];
            [weakSelf loadWithUrlStr:urlStr];
        }
    }];
    
    if (isIntercepted) {
        return NO;
    }
    return YES;
}


- (BOOL)p_webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    __weak typeof(self) weakSelf = self;
    
    [[AlipaySDK defaultService] payInterceptorWithUrl:[navigationAction.request.URL absoluteString] fromScheme:@"dayudoctor" callback:^(NSDictionary *result) {
        // 处理支付结果
        NSLog(@"%@", result);
        // isProcessUrlPay 代表 支付宝已经处理该URL
        if ([result[@"isProcessUrlPay"] boolValue]) {
            // returnUrl 代表 第三方App需要跳转的成功页URL
            NSString* urlStr = result[@"returnUrl"];
            if (!urlStr.length) {
                urlStr = weakSelf.detailUrl;
            }
            [weakSelf loadWithUrlStr:urlStr];
        }
    }];
    
    return YES;
}

- (void)webViewController:(AXWebViewController *)webViewController didFailLoadWithError:(NSError *)error {

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
- (void)loadWithUrlStr:(NSString*)urlStr
{
    if (urlStr.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                        cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                    timeoutInterval:30];
            [self.webView loadRequest:webRequest];
            CGFloat time = 0;
            if ([urlStr isEqualToString:_detailUrl]) {
                time = 0.5;
            } else {
                time = 2;
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:_detailUrl]
                                                            cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                        timeoutInterval:30];
                [DYZWebViewController clearWebCacheCompletion:^{
                    [self.webView loadRequest:webRequest];
                    NSArray *backList = self.webView.backForwardList.backList;
                    for (WKBackForwardListItem *item in backList) {
                        if ([item.URL.absoluteString isEqualToString:_detailUrl]) {
                            [self.webView goToBackForwardListItem:item];
                            break;
                        }
                    }
                }];
            });
        });
    }
}


- (void)dealloc{
    [self.userController removeScriptMessageHandlerForName:@"playVideo"];
    [self.userController removeScriptMessageHandlerForName:@"toHomeCategory"];
}

@end
