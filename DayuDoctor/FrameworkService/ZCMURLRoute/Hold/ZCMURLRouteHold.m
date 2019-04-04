//
//  ZCMURLRouteHold.m
//  ZCMURLRoute
//

#import "ZCMURLRouteHold.h"

NSString * const kRouteHoldLastViewController = @"ZCMURLRouteHoldLastViewController";
NSString * const kRouteHoldViewController = @"kRouteHoldViewController";
NSString * const kRouteHoldParameter = @"kRouteHoldParameter";



@interface ZCMURLRouteHold ()

@property (nonatomic, strong) ZCMURLRouteResult *routeResult;
@property (nonatomic, copy)ZCMURLRouteHoldCompleteBlock completeBlock;

@end

@implementation ZCMURLRouteHold

- (void)dealHoldWithRouteResult:(ZCMURLRouteResult *)routeResult completeBlock:(ZCMURLRouteHoldCompleteBlock)completeBlock {
    //检查passKeys
    [self.passKeys enumerateObjectsUsingBlock:^(NSString *propertyName, NSUInteger idx, BOOL *stop) {
        if ([propertyName isKindOfClass:[NSString class]]) {
            id lastViewController = routeResult.lastViewController;
            SEL selector = NSSelectorFromString(propertyName);
            if ([lastViewController respondsToSelector:selector]) {
                id viewController = routeResult.viewController;
                id propertyValue = [lastViewController valueForKey:propertyName];
                if ([viewController respondsToSelector:selector]) {
                    [viewController setValue:propertyValue forKey:propertyName];
                }
            }
        }
    }];
    //检查属性
    [self.checkKeys enumerateObjectsUsingBlock:^(NSString *propertyName, NSUInteger idx, BOOL *stop) {
        if ([propertyName isKindOfClass:[NSString class]]) {
            NSDictionary *param = routeResult.parameter;
            id obj = param[propertyName];
            if (!obj) {
                NSAssert(obj, ([NSString stringWithFormat:@"链接未提供页面%@值", propertyName]));
            }
        }
    }];
    //自定义操作
    BOOL dontHold = YES;
    if (self.holdController.length > 0) {
        Class cls = NSClassFromString(self.holdController);
        id<ZCMURLRouteHoldProtocol> holdObj = cls.new;
        if ([holdObj respondsToSelector:@selector(holdWithParameters:)]) {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            if (routeResult.viewController) [param setValue:routeResult.viewController forKey:kRouteHoldParameter];
            if (routeResult.lastViewController) [param setValue:routeResult.lastViewController forKey:kRouteHoldLastViewController];
            if (routeResult.parameter) [param setValue:routeResult.parameter forKey:kRouteHoldParameter];
            
            dontHold = NO;
            [holdObj holdWithParameters:param];
        }
    }
    //正常回调
    if (dontHold && completeBlock) {
        completeBlock(routeResult, routeResult.parameter);
    }
}

@end
