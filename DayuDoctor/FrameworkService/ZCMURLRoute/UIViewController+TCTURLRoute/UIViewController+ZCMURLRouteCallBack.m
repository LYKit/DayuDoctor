//
//  UIViewController+ZCMURLRouteCallBack.m
//  ZCMURLRoute
//

#import "UIViewController+ZCMURLRouteCallBack.h"
#import <objc/runtime.h>
#import "ZCMURLRouteCallBackProtocol.h"

NSString *ZCMURLRouteCallBackSourceClass = @"ZCMURLRouteCallBackSourceClass";

@implementation UIViewController (ZCMURLRouteCallBack)

- (UIViewController *)routeCallBackViewController {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setRouteCallBackViewController:(UIViewController *)routeCallBackViewController {
    objc_setAssociatedObject(self, @selector(routeCallBackViewController), routeCallBackViewController, OBJC_ASSOCIATION_ASSIGN);
}

//B页面调用，将callback数据给前一个页面
- (void)routeCallBack:(NSDictionary *)callback {
    UIViewController *lastViewController = self.routeCallBackViewController;
    if ([lastViewController respondsToSelector:@selector(routeCallBackWithParam:)]) {
        [(UIViewController<ZCMURLRouteCallBackProtocol> *)lastViewController routeCallBackWithParam:callback];
    }
}

@end
