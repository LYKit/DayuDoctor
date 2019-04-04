//
//  ZCMURLRoute.m
//  ZCMURLRoute
//

#import "ZCMURLRoute.h"
#import <UIKit/UIViewController.h>
#import "ZCMURLRouteConfig.h"
#import "ZCMURLRouteResult.h"
#import "ZCMURLRouteHold.h"
#import "ZCMRouteScheme.h"
#import "NSURL+ZCMURLChar.h"

static NSMutableDictionary *routeControllersMap = nil;

@interface ZCMURLRoute ()

@property (nonatomic, strong) NSDictionary *routeDictionary;

@end

@implementation ZCMURLRoute

+ (instancetype)defaultURLRoute {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = self.new;
    });
    return instance;
}

- (NSDictionary *)routeDictionary {
    return _routeDictionary ?: ({ _routeDictionary = [ZCMURLRouteConfig routeDictionary]; });
}

- (BOOL)routeWithURL:(NSURL *)URL options:(NSDictionary *)options completeblock:(ZCMURLRouteCompleteBlock)completeBlock {
    BOOL isStandard = [ZCMRouteScheme isStandardURL:URL];
    if (isStandard) {   //新规则
        NSMutableDictionary *blockParam = [NSMutableDictionary dictionary];
        [blockParam addEntriesFromDictionary:options];
        //根据URL在ZCMRoute得到dict，或者是一个对象，可以得到项目、页面
        ZCMRouteScheme *routeScheme = [[ZCMRouteScheme alloc] initWithURL:URL];
        //根据规则修改成可用URL
        [blockParam addEntriesFromDictionary:routeScheme.parameter];
        blockParam[kRouteResultUseableURL] = routeScheme.useableURL;
        blockParam[kRouteResultOriginalURL] = routeScheme.originalURL;
        
        ZCMURLRouteResult *routeResult = [[ZCMURLRouteResult alloc] initWithScheme:routeScheme.scheme];
        routeResult.lastViewController = blockParam[kRouteResultLastViewController];
        routeResult.parameter = blockParam;
        
        switch (routeResult.openType) {
            case URLRouteOpenNative: {
                //根据这个对象在routeDictionary里获取对应的ViewController类
                NSDictionary *schemeDictionary = self.routeDictionary[routeScheme.scheme];
                if (!schemeDictionary) {
                    return NO;
                }
                NSDictionary *moduleDictionary = schemeDictionary[routeScheme.module];
                if (!moduleDictionary) {
                    NSLog(@"%@", [NSString stringWithFormat:@"ZCMURLRoute module值错误：“%@”不存在", routeScheme.module]);
                    return NO;
                }
                NSDictionary *pageDictionary = moduleDictionary[routeScheme.page];
                if (!pageDictionary) {
                    NSLog(@"%@", [NSString stringWithFormat:@"ZCMURLRoute page值错误：“%@”不存在", routeScheme.page]);
                    return NO;
                }

                NSString *bundleName = pageDictionary[kRouteConfigBundle] ?: moduleDictionary[kRouteConfigBundle];
                routeResult.viewController = [self viewControllerWithPageDictionary:pageDictionary withBundleName:bundleName];
                
                ZCMURLRouteHold *routeHold = [self routeHoldWithPageDictionary:pageDictionary];
                if (routeHold) {
                    [routeHold dealHoldWithRouteResult:routeResult completeBlock:completeBlock];
                }
                else {
                    if (completeBlock) completeBlock(routeResult, blockParam);
                }
            }
                break;
            case URLRouteOpenWeb: {
                NSDictionary *pageDictionary = self.routeDictionary[routeScheme.scheme];
                if (!pageDictionary) {
                    NSLog(@"%@", [NSString stringWithFormat:@"ZCMURLRoute page值错误：“%@”不存在", routeScheme.scheme]);
                    return NO;
                }
                routeResult.viewController = [self viewControllerWithPageDictionary:pageDictionary withBundleName:nil];
                routeResult.parameter = blockParam;    //将UseableURL传出去
                
                ZCMURLRouteHold *routeHold = [self routeHoldWithPageDictionary:pageDictionary];
                if (routeHold) {
                    [routeHold dealHoldWithRouteResult:routeResult completeBlock:completeBlock];
                }
                else {
                    if (completeBlock) completeBlock(routeResult, blockParam);
                }
            }
                break;
            case URLRouteOpenExternal: {
                if (completeBlock) completeBlock(routeResult, blockParam);
            }
                break;
            default: {
                //FIXME:默认操作，打开一个网址，传入无法解析的URL
            }
                break;
        }
    }
    else {  //20160307 错误规则直接跳转外部
        NSString *scheme = @"http";
        ZCMURLRouteResult *routeResult = [[ZCMURLRouteResult alloc] initWithScheme:scheme];
        routeResult.lastViewController = options[kRouteResultLastViewController];
        routeResult.parameter = options;
        
        NSDictionary *pageDictionary = self.routeDictionary[scheme];
        routeResult.viewController = [self viewControllerWithPageDictionary:pageDictionary withBundleName:nil];
        routeResult.parameter = options;    //将UseableURL传出去
        
        ZCMURLRouteHold *routeHold = [self routeHoldWithPageDictionary:pageDictionary];
        if (routeHold) {
            [routeHold dealHoldWithRouteResult:routeResult completeBlock:completeBlock];
        }
        else {
            if (completeBlock) completeBlock(routeResult, options);
        }
        return NO;
    }
    return YES;
}

- (UIViewController *)viewControllerWithPageDictionary:(NSDictionary *)pageDictionary withBundleName:(NSString *)bundleName {
    NSString *pageClassName = pageDictionary[kRouteConfigClass];
    if (pageClassName.length) {
        NSString *pageBundleName = pageDictionary[kRouteConfigBundle] ?: bundleName;
        NSString *pageNibName = pageDictionary[kRouteConfigNib] ?: pageClassName;
        
        Class cls = NSClassFromString(pageClassName);
        if (cls && [cls isSubclassOfClass:[UIViewController class]]) {
            NSBundle *bundle = nil;
            if (pageBundleName.length) {
                bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:pageBundleName ofType:@"bundle"]];
            }
            pageNibName = [pageNibName length] > 0 ? pageNibName : nil;
            id retObj = bundle ? ([[cls alloc] initWithNibName:pageNibName bundle:bundle]) : ([[cls alloc] init]);
            return retObj;
        }
        else {
            NSLog(@"%@", [NSString stringWithFormat:@"ZCMURLRoute %@类不存在", pageClassName]);
        }
    }
    return nil;
}

- (ZCMURLRouteHold *)routeHoldWithPageDictionary:(NSDictionary *)pageDictionary {
    NSDictionary *pageHoldDictionary = pageDictionary[kRouteConfigHold];
    if ([pageHoldDictionary isKindOfClass:[NSDictionary class]]) {
        ZCMURLRouteHold *routeHold = ZCMURLRouteHold.new;
        routeHold.holdController = pageHoldDictionary[kRouteConfigClass];    //类最后处理
        routeHold.passKeys = pageHoldDictionary[kRouteConfigPassKeys];
        routeHold.checkKeys = pageHoldDictionary[kRouteConfigCheckKeys];
        return routeHold;
    }
    return nil;
}

@end
