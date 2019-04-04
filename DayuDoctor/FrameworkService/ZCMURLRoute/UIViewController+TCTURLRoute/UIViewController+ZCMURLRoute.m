//
//  UIViewController+ZCMURLRoute.m
//  ZCMURLRoute
//
//  Created by 赵学良 on 2018/9/24.
//  Copyright © 2018年 zhaoxueliang. All rights reserved.
//


#import "UIViewController+ZCMURLRoute.h"
#import "UIViewController+ZCMURLRouteCallBack.h"
#import <objc/runtime.h>
#import "ZCMURLRoute.h"
#import "ZCMURLRouteResult.h"
#import "ZCMURLBridge.h"
#import "NSURL+ZCMURLChar.h"

NSString *const ZCMURLRouteHandleErrorNotification = @"ZCMURLRouteHandleErrorNotification";
NSString *const ZCMURLRouteHandleCompleteNotification = @"ZCMURLRouteHandleCompleteNotification";
NSString *const kURLRouteOpenAnimated = @"kURLRouteOpenAnimated";           //是否需要动画
NSString *const kURLRouteOpenAnimatedTransition = @"kURLRouteOpenAnimatedTransition"; //动画形式
NSString *const kURLRouteOpenCompletion = @"kURLRouteOpenCompletion";         //完成后回调操作

extern NSString * const kRouteOriginalURLString;

@implementation UIViewController (ZCMURLRoute)

#pragma mark -
- (void)openRouteURL:(NSURL *)url options:(NSDictionary *)options parameter:(NSDictionary *)parameter {
    if (!url) return;
    NSURL *newURL = url;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[kRouteResultLastViewController] = [self p_route_lastViewController];
    dictionary[kRouteResultUseableURL] = newURL;
    [dictionary addEntriesFromDictionary:options];
    
    [self p_route_openRouteURL:newURL options:dictionary parameter:parameter];
}

#pragma mark -
- (UIViewController *)p_route_lastViewController {
    UIViewController *viewController = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        viewController = ((UINavigationController *)self).topViewController;
    }
    else if ([self isKindOfClass:[UIViewController class]]) {
        viewController = self;
    }
    else {
        NSAssert(viewController, ([NSString stringWithFormat:@"ZCMURLRoute Tip:缺少Nav"]));
    }
    return viewController;
}

- (void)p_route_openRouteURL:(NSURL *)routeURL options:(NSDictionary *)dict parameter:(NSDictionary *)parameter
{
    BOOL success = [p_route_URLRoute() routeWithURL:routeURL options:dict completeblock:^(ZCMURLRouteResult *result, NSDictionary *otherOptions) {
        NSDictionary *options = otherOptions ?: dict;
        switch (result.openType) {
            case URLRouteOpenWeb:
            case URLRouteOpenNative: {
                UIViewController *viewController = result.viewController;
                UIViewController *lastViewController = result.lastViewController;
                //设置callback值
                viewController.routeCallBackViewController = lastViewController;
                
                NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:result.parameter];
                if (parameter.allValues) {
                    [param addEntriesFromDictionary:parameter];
                }
                if (lastViewController) {
                    //Push前回调，供对象属性参数初始化
                    if ([viewController respondsToSelector:@selector(routeWillPushControllerWithParam:)]) {
                        [viewController routeWillPushControllerWithParam:param];
                    }
                    //具体页面打开操作
                    NSArray *allOpenKeys = options.allKeys;
                    BOOL animated = YES;
                    if ([allOpenKeys containsObject:kURLRouteOpenAnimated]) {
                        animated = [options[kURLRouteOpenAnimated] boolValue];
                    }
                    ZCMURLRouteOpenCompletion completion = nil;
                    if ([allOpenKeys containsObject:kURLRouteOpenCompletion]) {
                        completion = options[kURLRouteOpenCompletion];
                    }
                    URLRouteOpenAnimatedTransition openType = URLRouteOpenAnimatedPush;
                    if ([allOpenKeys containsObject:kURLRouteOpenAnimatedTransition]) {
                        openType = [options[kURLRouteOpenAnimatedTransition] integerValue];
                    }
                    switch (openType) {
                        case URLRouteOpenAnimatedPush: {
                            [lastViewController.navigationController pushViewController:viewController animated:animated];
                            if (completion) completion();
                        } break;
                        case URLRouteOpenAnimatedPresent: {
                            [lastViewController presentViewController:viewController animated:animated completion:completion];
                        } break;
                        default:
                            break;
                    }
                    //Push后回调，做一些清理操作
                    if ([viewController respondsToSelector:@selector(routeDidPushControllerWithParam:)]) {
                        [viewController routeDidPushControllerWithParam:param];
                    }
                }
                else {
                    NSAssert(lastViewController, ([NSString stringWithFormat:@"%@的NavigationController不存在，无法push", NSStringFromClass([self class])]));
                }
            }
                break;
            case URLRouteOpenExternal: {
                NSURL *URL = options[kRouteResultUseableURL];
                [[UIApplication sharedApplication] openURL:URL];
            }
                break;
            default: break;
        }
    }];
    if (success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZCMURLRouteHandleCompleteNotification object:dict];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZCMURLRouteHandleErrorNotification object:routeURL];
    }
}

#pragma mark -
static ZCMURLRoute *p_route_URLRoute() {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = ZCMURLRoute.new;
    });
    return instance;
}

@end

@implementation UIViewController (ZCMURLRouteCompatible)

- (void)openRouteURLString:(NSString *)aString parameter:(NSDictionary *)parameter {
    [self openRouteURLString:aString parameter:parameter options:nil];
}

- (void)openRouteURLString:(NSString *)aString options:(NSDictionary *)options {
    [self openRouteURLString:aString parameter:nil options:options];
}

- (void)openRouteURLString:(NSString *)aString parameter:(NSDictionary *)parameter options:(NSDictionary *)options {
    if (!aString.length) return;
#if DEBUG
    NSLog(@"URLRoute准备接收");
    NSLog(@"URLRoute已接收%@", aString);
    NSLog(@"URLRoute验证转换状态");
#endif
    NSURL *url = [ZCMURLBridge routeURLFromString:aString];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:aString forKey:kRouteOriginalURLString];
    [dictionary addEntriesFromDictionary:options];
    [self openRouteURL:url options:dictionary parameter:parameter];
}

- (void)openRouteWithModule:(NSString *)module page:(NSString *)page parameter:(NSDictionary *)parameter {
    NSURL *url = [ZCMURLBridge routeURLWithModule:module page:page parameter:nil];
    [self openRouteURL:url options:nil parameter:parameter];
}

@end


@implementation UIViewController (ZCMURLRouteHoldObject)

- (id)holdObject {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setHoldObject:(id)holdObject {
    objc_setAssociatedObject(self, @selector(holdObject), holdObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
